namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_physicians_and_patients
    make_visits
  end
end

def make_physicians_and_patients
  admin = Physician.create!(first_name:     "Brijesh",
                       last_name: "Shetty",
                       email:    "brij@gmail.com",
                       dob: Date.parse("1982/12/11"),
                       mobile: Faker::PhoneNumber.phone_number,
                       password: "welcome",
                       password_confirmation: "welcome")
  admin.toggle!(:admin)
  
  physician = Physician.create!(first_name:     "Preeti",
                       last_name: "Aiyar",
                       email:    "preeti@gmail.com",
                       dob: Date.parse("1982/10/28"),
                       mobile: Faker::PhoneNumber.phone_number,
                       password: "welcome",
                       password_confirmation: "welcome")

  seconds_year = 24 * 60 * 60 * 365
  
  25.times do |n|
    admin.patients.create!(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: "example-#{n+1}@railstutorial.org",
      dob: rand_date(Time.now - seconds_year*70, Time.now - seconds_year*10),
      mobile: Faker::PhoneNumber.phone_number,
      sex: ["Male", "Female"].sample )
  end

  email_offset = 26
  25.times do |n|
    physician.patients.create!(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: "example-#{n+1+email_offset}@railstutorial.org",
      dob: rand_date(Time.now - seconds_year*70, Time.now - seconds_year*10),
      mobile: Faker::PhoneNumber.phone_number,
      sex: ["Male", "Female"].sample )
  end
  
end


def make_visits
  patients = Patient.all(limit: 50)
  25.times do
    reference_no = 1 + Random.rand(500000)
    complaints = Faker::Lorem.sentences(3)
    findings = Faker::Lorem.sentence(5)
    treatment = Faker::Lorem.sentences(2)
    
    seconds_day = 24 * 60 * 60
    patients.each { |patient| patient.visits.create!(
          reference_number: reference_no,
          date_of_visit: rand_date(Time.now - seconds_day*50, Time.now),
          complaints: complaints,
          findings: findings, 
          treatment: treatment) }
    
  end
end



def rand_int(from, to)
  rand_in_range(from, to).to_i
end

def rand_date(from, to)
  "12/11/2011"
  # Time.at(rand_in_range(from.to_f, to.to_f)).to_date
end

def rand_in_range(from, to)
  rand * (to - from) + from
end


