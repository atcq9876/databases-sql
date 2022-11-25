require_relative 'lib/database_connection'
require_relative 'lib/cohort'
require_relative 'lib/student'
require_relative 'lib/cohort_repository'

DatabaseConnection.connect('student_directory_2')

repo = CohortRepository.new
cohort = repo.find_with_students(1)

p "Cohort ID: #{cohort.id}"
p "Cohort name: #{cohort.name}"
p "Cohort starting date: #{cohort.starting_date}"
p "Students in this cohort:"
cohort.students.each do |record|
  p "#{record.id} - #{record.name}"
end