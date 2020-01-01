#! ruby

require 'csv'

def kv_pair(k, v)
  print "\t\t\"" + k + "\": \"" + v + "\"\n"
end

first_time = true

print "{\n\"students\": ["

students = CSV.read(ARGV[0])
students.each { |student|
  if (first_time == true)
    first_time = false
  else
    print ","
  end
  print "{\n"
  kv_pair("name", student[0])
  kv_pair("repo", "")
  print "\t}"
}
puts "]\n}"
