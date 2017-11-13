require 'json'
require 'pg'

class TutorIndexer
  def index
    puts 'Running indexer...'
    wipe_old_data
    conn = get_db_connection
    prepare_select(conn)
    get_tutors(conn)
    create_index
  end

  private

  def wipe_old_data
    Course.delete_all
    Tutor.delete_all
  end

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
         where user_type = 'TUTOR';")
  end

  def get_tutors(conn)
    result = conn.exec_prepared (
      'select tutors'
    )
    result.values.each do |row|
      t = Tutor.where(uuid: row[0])[0]
      if (!t) #then add course
        t = Tutor.create(
          uuid: row[0], first_name: row[1], last_name: row[2],
          email: row[3], year: row[4], program: row[5],
          faculty: row[6]
        )
      end
      t.courses.create(code: row[7], course_name: row[8], description: row[9])
      p t
    end
  end

  def create_index
      Tutor.all.each_with_index do |tut, idx|
        Elasticsearch::Model.client.index(index: 'tutors',
                    type: 'tutor',
                      id: idx,
                    body: tut.to_indexed_json)
        # puts tut.to_indexed_json
      end
  end
end
