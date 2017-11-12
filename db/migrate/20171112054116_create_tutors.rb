class CreateTutors < ActiveRecord::Migration[5.1]
  def change
    create_table :tutors do |t|
      t.text :uuid
      t.text :first_name
      t.text :last_name
      t.text :email
      t.integer :year
      t.text :program
      t.text :faculty

      t.timestamps
    end
  end
end
