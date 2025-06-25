class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :courses do |t|
      t.string :title, null: false
      t.integer :total_hours, null: false
      t.decimal :price, precision: 8, scale: 2
      t.string :school, null: false
      t.date :date
      t.string :time_period, null: false
      t.text :description

      t.timestamps
    end

    add_index :courses, :title
    add_index :courses, :school
    add_index :courses, :time_period
  end
end
