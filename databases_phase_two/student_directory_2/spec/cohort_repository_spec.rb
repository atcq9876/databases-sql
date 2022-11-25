require 'cohort_repository'

def reset_tables
  seed_sql = File.read('spec/seeds_student_directory_2.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'student_directory_2' })
  connection.exec(seed_sql)
end

RSpec.describe CohortRepository do

  before(:each) do 
    reset_tables
  end

  describe "#find_with_students(id)" do
    it "returns a cohort record and lists all students in that cohort" do
      repo = CohortRepository.new
      cohort = repo.find_with_students(1)
      
      expect(cohort.id).to eq '1'
      expect(cohort.name).to eq 'One'
      expect(cohort.starting_date).to eq '2022-09-01'
      expect(cohort.students.length).to eq 2
      expect(cohort.students.first.name).to eq 'Andy'
      expect(cohort.students.last.name).to eq 'James'
      expect(cohort.students.first.id).to eq '1'
      expect(cohort.students.last.id).to eq '2'
    end
  end
end