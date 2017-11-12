require './app/models/tutor.rb'
a = Tutor.new(uuid: 'fake_uuid', first_name: 'fake_first', last_name: 'fake_last',
              email: 'fake_email@gmail.com', year: 3, program: 'fake_program',
              faculty: 'fake_fac')
a.save
