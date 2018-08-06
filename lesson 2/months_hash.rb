months = { "January" => 30, "February" => 28, "March" => 31, "April" => 30, "May" => 31, "Juny" => 30, "July" => 31, "August" => 31, "September" => 30, "October" => 31, "November" => 30, "December" => 31 }
months.each do |month, days|
  if months[month] == 30
  puts "#{month} has #{days} days."
end
end
