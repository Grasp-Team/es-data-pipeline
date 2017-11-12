require 'json'
require 'pg'

class TutorIndexer
  def index
    puts 'Running indexer...'
    conn = get_db_connection
    prepare_select(conn)
    # a = Tutor.new(uuid: 'fake_uuid', first_name: 'fake_first', last_name: 'fake_last',
    #             email: 'fake_email@gmail.com', year: 3, program: 'fake_program',
    #             faculty: 'fake_fac')
    # a.save
    get_tutors(conn)
  end

  private

  def get_db_connection
    PG::Connection.open(
      host: ENV.fetch('DB_HOST'),
      port: ENV.fetch('DB_PORT'),
      dbname: ENV.fetch('DB_NAME'),
      user: ENV.fetch('DB_USER'),
      password: ENV.fetch('DB_PASS')
    )
  end

  def prepare_select(conn)
    conn.prepare('select tutors',
      "select users.id, users.first_name, users.last_name, users.email, users.year,
              users.program, users.faculty, course_catalog.code, course_catalog.course_name,
              course_catalog.description
       from users.users
       left join users.tutors
                 on users.id = tutors.uid
       left join course.course_catalog
                 on tutors.course_code = course_catalog.code
       where user_type = 'Tutor';")
  end

  def get_tutors(conn)
    puts 'hello?'
    result = conn.exec_prepared (
      'select tutors'
    )
    puts result.values
  end

  def create_tutors(tutors)
  end
end
