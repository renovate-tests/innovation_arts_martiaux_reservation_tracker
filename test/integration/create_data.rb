require 'watir'
require 'watir-scroll'
require 'faker'

def flash_and_ensure_click(an_element)
  an_element.wait_until(&:present?)
  an_element.scroll.to
  an_element.flash
  an_element.click
end

def create_browser
  @browser = Watir::Browser.start('http://localhost:3000/')
end

def create_users
  create_browser

  5000.times do |iteration|

    flash_and_ensure_click(@browser.link(text: 'Nouveau Client'))
    username = Faker::Name.name
    @browser.text_field(id: 'user_name').set username
    @browser.text_field(id: 'user_telephone').set Faker::PhoneNumber.phone_number
    @browser.text_field(id: 'user_email').set Faker::Internet.email
    @browser.text_field(id: 'user_password').set 'rsft789p'
    @browser.text_field(id: 'user_password_confirmation').set 'rsft789p'
    @browser.button(type: 'submit').click
    @browser.div(id: 'notice').flash
    seed = Random.new
    student_count = seed.rand(3) + 1
    create_students(student_count, username)
    puts "User #{username} created"
    flash_and_ensure_click(@browser.link(text: 'Deconnecter'))
  end
end


def create_students(iterations = 325, _username)
  flash_and_ensure_click(@browser.link(text: 'Étudiants'))
  iterations.times do |iteration|
    flash_and_ensure_click(@browser.link(text: 'Étudiants'))
    flash_and_ensure_click(@browser.link(text: 'Nouvel Étudiant'))
    seed = Random.new
    student_is_also_a_client = (seed.rand(100) < 30)
    flash_and_ensure_click(@browser.text_field(id: 'student_name'))
    student_name = if student_is_also_a_client
                     Faker::Name.name
                   else
                     _username
                   end

    @browser.text_field(id: 'student_name').set student_name

    @browser.select(id: 'student_date_of_birth_3i').options[seed.rand(31)].click
    @browser.select(id: 'student_date_of_birth_2i').options[seed.rand(12)].click
    @browser.select(id: 'student_date_of_birth_1i').options[seed.rand(70)].click
    @browser.button(type: 'submit').click
    @browser.div(id: 'notice').flash
    flash_and_ensure_click(@browser.link(text: 'Retour'))
    reservations_count = seed.rand(4) + 1
    create_reservations(reservations_count)
  end
end


def create_reservations(iterations = 5)
  flash_and_ensure_click(@browser.link(id: 'reservations'))
  seed = Random.new
  iterations.times do |iteration|
    flash_and_ensure_click(@browser.link(id: 'new_reservation'))
    student_list = @browser.select(id: 'reservation_student_id').length
    @browser.select(id: 'reservation_student_id').options[seed.rand(student_list)].click
    course_list = @browser.select(id: 'reservation_course_id').length
    @browser.select(id: 'reservation_course_id').options[seed.rand(course_list)].click
    @browser.button(type: 'submit').click
    @browser.div(id: 'notice').flash
    flash_and_ensure_click(@browser.link(text: 'Retour'))
  end
end


def create_graduations
  create_browser
  flash_and_ensure_click(@browser.link(text: 'Graduations'))
  350.times do |iteration|
    flash_and_ensure_click(@browser.link(text: 'Ajouter Graduation'))
    seed = Random.new
    student_count = @browser.select_list(:id => 'graduation_student_id').options.count
    @browser.select(id: 'graduation_student_id').options[seed.rand(student_count)].click
    course_count = @browser.select_list(:id => 'graduation_belt_id').options.count
    @browser.select(id: 'graduation_belt_id').options[seed.rand(course_count)].click
    @browser.select(id: 'graduation_graduation_date_3i').options[seed.rand(30)].click
    @browser.select(id: 'graduation_graduation_date_2i').options[seed.rand(12)].click


    @browser.button(type: 'submit').click
    @browser.div(id: 'notice').flash
    flash_and_ensure_click(@browser.link(text: 'Retour'))
  end
end


def get_action
  puts "Enter action:"
  puts "1- Create Users"
  puts "2- Create Students"
  puts "3- Create Reservations"
  puts "4- Create Graduations"
  gets.strip
end

action_to_run = get_action

case action_to_run
when "1"
  begin
    create_users
  rescue => exception
    puts exception
    @browser.quit
    retry
  end
when "2"
  begin
    create_students
  rescue => exception
    puts exception
    @browser.quit
    retry
  end
when "3"
  begin
    create_reservations
  rescue => exception
    puts exception
    @browser.quit
    retry
  end
when "4"
  begin
    create_graduations
  rescue => exception
    puts exception
    @browser.quit
    retry
  end
else
  puts "Wrong Selection"
  get_action
end
