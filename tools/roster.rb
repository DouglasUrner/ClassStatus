#!/usr/bin/env ruby

# Roster driver - given a CSV file of student demographics, generate
# the initial JSON to populate the tiles.

# TODO: finish normalizing name presentation.
# TODO: map to preferred name.
# TODO: pronouns?

require 'csv'

def kv_pair(k, v)
  print "\t\t\"" + k + "\": \"" + v + "\"\n"
end

def clean_name(n)
  # 0: preficx
  # 1: given name
  # 2: middle name
  # 3: family name
  # 4: suffix
  parts = Array.new
  tmp1 = n.split(/,\s*/)
  parts[3] = tmp1[0]
  tmp1[1].strip!
  tmp2 = tmp1[1].split(/\s\s*/)
  parts[1] = tmp2[0]
  parts[2] = tmp2[1]
  parts
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

  names = clean_name(student[0])

  print "{\n"
  kv_pair("fn", names[1])
  kv_pair("ln", names[3])
  kv_pair("GHuser", "")
  print "\t}"
}
puts "]\n}"
