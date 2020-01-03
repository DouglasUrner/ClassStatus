### Associating students with sections and persisting student data

**Tables:**
```
students
  has_many :sections, through: :enrollments

sections
  has_many :students, through: :enrollments

enrollments
  belongs_to :student
  belongs_to :section

  attendance
  seat
```
