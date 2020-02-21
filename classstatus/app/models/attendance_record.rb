class AttendanceRecord < ApplicationRecord
  belongs_to :section
  belongs_to :student

  # XXX: Validate attendance_date?

  enum primary:    { in_class: 'in_class', absent: 'absent', tardy: 'tardy', tardy_10: 'tardy_10' }
  enum secondary:  { lunch_absent: 'lunch_absent', lunch_tardy: 'lunch_tardy', lunch_tardy_10: 'lunch_tardy_10' }
  enum annotation: { called_out: 'called_out', early_release: 'early_release'}
end
