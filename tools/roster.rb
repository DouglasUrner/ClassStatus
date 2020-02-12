#!/usr/bin/env ruby

# Roster driver - given a CSV file of student demographics, generate
# the initial JSON to populate the tiles.

# TODO: finish normalizing name presentation.
# TODO: pronouns?

# Columns (as returned by split):
# 0: Last, First M.
# 1: Student ID
# 2: Birthdate
# 3: GPA
# 4: Gender
# 5: Graduation cohort

require 'csv'
require 'json'

def kv_pair(k, v, comma)
  print "\t\t\"" + k + "\": \"" + v + "\""
  if (comma)
    print ",\n"
  else
    print "\n"
  end
end

def clean_name(n)
  # 0: prefix
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

def fix_dob(d)
  # Dates is Skyward are not consistant some are MM/DD/YY, others are
  # YYYY-MM-DD. Handle both.
  ymd = ""
  if (d.match('/'))
    dmy = d.split('/')
    y = (dmy[2] < "20") ? "20" + dmy[2] : "19" + dmy[2]
    ymd = y + '-' + dmy[0] + '-' + dmy[1]
  elsif (d.match('-'))
    ymd = d
  end
  ymd
end

def fix_guid(guid)
  # Our GUIDs start with 0 (most of the time) and are seven digits long.
  # Make it so...
  if (guid.length != 7 && guid[0] != '0')
    guid = '0' + guid
  end
  guid
end

first_time = true
timestamp = File.mtime(ARGV[0])

print "{\n\"students\": ["

skip_lines = 7

students = CSV.read(ARGV[0])
students.each { |student|
  if (skip_lines > 0)
    skip_lines -= 1
    next
  end

  if (first_time == true)
    first_time = false
  else
    print ","
  end

  names = clean_name(student[0])
  dob = fix_dob(student[2])
  gender = student[4] == 'Male' ? 'M' : 'F'
  guid = fix_guid(student[1])

  print "{\n"
  kv_pair("guid", guid, true)
  kv_pair("given_name", names[1], true)
  kv_pair("family_name", names[3], true)
  kv_pair("gender", gender, true)
  kv_pair("dob", dob, true)
  kv_pair("cohort", student[5], true)
  kv_pair("github_user", "", true)
  kv_pair("gpa", student[3], true)
  kv_pair("gpa_updated", timestamp.to_s, false)
  print "\t}"
}
puts "]\n}"
