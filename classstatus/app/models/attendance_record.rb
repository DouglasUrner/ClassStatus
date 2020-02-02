class AttendanceRecord < ApplicationRecord
  belongs_to :student
  belongs_to :section

  enum state: {
    # Can't use 'present' because it's a Rails keyword.
    in_class:   'in_class',
    absent:     'absent',
    tardy:      'tardy',
    tardy10:    'tardy10',
    called_out: 'called_out'
  }
end
