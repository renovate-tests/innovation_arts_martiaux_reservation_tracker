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

def create_clients
  create_browser
  flash_and_ensure_click(@browser.a(text: 'Clients'))

  325.times do |iteration|

    flash_and_ensure_click(@browser.a(text: 'Nouveau Client'))
    @browser.text_field(id: 'client_name').set Faker::Name.name
    @browser.text_field(id: 'client_telephone').set Faker::PhoneNumber.phone_number
    @browser.text_field(id: 'client_email').set Faker::Internet.email
    @browser.checkbox(id: 'client_active').clear if iteration % 11 == 0
    @browser.button(type: 'submit').click
    @browser.p(id: 'notice').flash
    flash_and_ensure_click(@browser.a(text: 'Retour'))
  end
end


def create_students
  create_browser
  flash_and_ensure_click(@browser.a(text: 'Étudiants'))
  350.times do |iteration|
    flash_and_ensure_click(@browser.a(text: 'Nouvel Étudiant'))
    seed = Random.new
    student_is_also_a_client = seed.rand(100) < 30

    client_count = @browser.select_list(:id => 'student_client_id').options.count
    @browser.select(id: 'student_client_id').options[seed.rand(client_count)].click

    if student_is_also_a_client
      @browser.text_field(id: 'student_name').set @browser.select(id: 'student_client_id').selected_options.map(&:text)
    else
      @browser.text_field(id: 'student_name').set Faker::Name.name
    end

    @browser.select(id: 'student_date_of_birth_3i').options[seed.rand(31)].click
    @browser.select(id: 'student_date_of_birth_2i').options[seed.rand(12)].click
    @browser.select(id: 'student_date_of_birth_1i').options[seed.rand(70)].click
    @browser.checkbox(id: 'student_active').clear if iteration % 11 == 0
    @browser.checkbox(id: 'student_trial_class').set if iteration % 5 == 0
    @browser.checkbox(id: 'student_uniform_promotion').set if iteration % 8 == 0
    @browser.button(type: 'submit').click
    @browser.p(id: 'notice').flash
    flash_and_ensure_click(@browser.a(text: 'Retour'))
  end
end


def create_reservations
  create_browser
  flash_and_ensure_click(@browser.a(text: 'Réservations'))
  350.times do |iteration|
    flash_and_ensure_click(@browser.a(text: 'Nouvelle Réservation'))
    seed = Random.new
    student_count = @browser.select_list(:id => 'reservation_student_id').options.count
    @browser.select(id: 'reservation_student_id').options[seed.rand(student_count)].click
    course_count = @browser.select_list(:id => 'reservation_course_id').options.count
    @browser.select(id: 'reservation_course_id').options[seed.rand(course_count)].click

    @browser.checkbox(id: 'reservation_active').clear if iteration % 11 == 0

    @browser.button(type: 'submit').click
    @browser.p(id: 'notice').flash
    flash_and_ensure_click(@browser.a(text: 'Retour'))
  end
end


def create_graduations
  create_browser
  flash_and_ensure_click(@browser.a(text: 'Graduations'))
  350.times do |iteration|
    flash_and_ensure_click(@browser.a(text: 'Ajouter Graduation'))
    seed = Random.new
    student_count = @browser.select_list(:id => 'graduation_student_id').options.count
    @browser.select(id: 'graduation_student_id').options[seed.rand(student_count)].click
    course_count = @browser.select_list(:id => 'graduation_belt_id').options.count
    @browser.select(id: 'graduation_belt_id').options[seed.rand(course_count)].click
    @browser.select(id: 'graduation_graduation_date_3i').options[seed.rand(30)].click
    @browser.select(id: 'graduation_graduation_date_2i').options[seed.rand(12)].click


    @browser.button(type: 'submit').click
    @browser.p(id: 'notice').flash
    flash_and_ensure_click(@browser.a(text: 'Retour'))
  end
end


def get_action
  puts "Enter action:"
  puts "1- Create Clients"
  puts "2- Create Students"
  puts "3- Create Reservations"
  puts "4- Create Graduations"
  gets.strip
end

action_to_run = get_action

case action_to_run
when "1"
  begin
    create_clients
  rescue
    retry
  end
when "2"
  begin
    create_students
  rescue
    retry
  end
when "3"
  begin
    create_reservations
  rescue
    retry
  end
when "4"
  begin
    create_graduations
  rescue
    retry
  end
else
  puts "Wrong Selection"
  get_action
end
