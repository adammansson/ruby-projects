require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'
require 'time'

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, '0')[0..4]
end

def clean_phone_number(phone_number)
  phone_number = phone_number.gsub(/[()\-,. ]/, '')
  if phone_number.length == 10
    phone_number
  elsif phone_number.length == 11 && phone_number[0] == '1'
    phone_number[1..10]
  else
    '0000000000'
  end
end

def clean_date(date)
  date = date.split('/')
  date[2] = '20' + date[2]
  date.join('-')
end

def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    legislators = civic_info.representative_info_by_address(
      address: zip,
      levels: 'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    )
    legislators.officials
  rescue
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end

def save_thank_you_letter(id, form_letter)
  Dir.mkdir('output') unless Dir.exist?('output')
  filename = "output/thanks_#{id}.html"
  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

def highest_frequencies(array)
  frequency_hash = array.tally
  highest_frequencies = frequency_hash.values.max
  frequency_hash.filter { |key, value| value == highest_frequencies }
end

puts 'Event manager initialized!'

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

template_letter = File.read('form_letter.erb')
erb_template = ERB.new(template_letter)

registration_hours = []
registration_days = []

contents.each do |row|
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])

  phone_number = clean_phone_number(row[:homephone])

  time_of_registration = row[:regdate].split.last
  registration_hours.push(Time.strptime(time_of_registration, "%k:%M").hour)

  date_of_registration = clean_date(row[:regdate].split.first)
  registration_days.push(Date.strptime(date_of_registration, '%m-%d-%Y').wday)

  legislators = legislators_by_zipcode(zipcode)

  form_letter = erb_template.result(binding)
  save_thank_you_letter(id, form_letter)
end

puts "Time targeting: #{highest_frequencies(registration_hours)}"

highest_frequencies_weekday =
  highest_frequencies(registration_days).map do |key, value|
    [Date::DAYNAMES[key], value]
  end.to_h
puts "DOW targeting: #{highest_frequencies_weekday}"

