class AddTutorReferenceToCourses < ActiveRecord::Migration[5.1]
  def change
    add_reference :courses, :tutor, foreign_key: true
  end
end
