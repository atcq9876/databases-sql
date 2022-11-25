require_relative 'cohort'
require_relative 'student'

class CohortRepository
  
  # Find one cohort and list students in this cohort
  # (in lib/cohort_repository.rb)
  def find_with_students(id)
    sql = "SELECT cohorts.id AS cohort_id,
          cohorts.name AS cohort_name,
          cohorts.starting_date,
          students.name AS student_name,
          students.id AS student_id
          FROM cohorts
          JOIN students ON cohorts.id = students.cohort_id
          WHERE cohorts.id = $1;"

    params = [id]

    result_set = DatabaseConnection.exec_params(sql, params)
    record = result_set[0]

    cohort = Cohort.new
    cohort.id = record["cohort_id"]
    cohort.name = record["cohort_name"]
    cohort.starting_date = record["starting_date"]

    result_set.each do |record|
      student = Student.new
      student.id = record["student_id"]
      student.name = record["student_name"]
      cohort.students << student
    end

    return cohort 
  end
end