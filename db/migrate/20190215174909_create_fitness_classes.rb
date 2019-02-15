class CreateFitnessClasses < ActiveRecord::Migration
  def change
    create_table :fitness_classes do |t|
      t.string :name
      t.date :date
      t.time :time
      t.string :location
      t.string :instructor
      t.integer :user_id
    end
  end
end
