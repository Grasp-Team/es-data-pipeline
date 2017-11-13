class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.text :code
      t.text :course_name
      t.text :description

      t.timestamps
    end
  end
end
