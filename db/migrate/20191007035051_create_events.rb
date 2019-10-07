class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :title
      t.datetime :startDate
      t.datetime :endDate
      t.string :street
      t.string :neighborhood
      t.string :city
      t.string :reference_point
      t.string :description
      t.references :event_type, foreign_key: true
      t.references :user, foreign_key: true
      t.boolean :status

      t.timestamps
    end
  end
end
