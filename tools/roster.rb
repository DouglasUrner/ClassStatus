#!/usr/bin/env ruby

# Roster driver - given a CSV file of student demographics, generate
# the initial JSON to populate the tiles.

# TODO: normalize name presentation.
# TODO: split given and family name.
# TODO: map to preferred name.
# TODO: pronouns?

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
  kv_pair("GHuser", "")
  print "\t}"
}
puts "]\n}"
