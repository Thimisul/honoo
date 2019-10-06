class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :title
      t.datetime :start_date
      t.datetime :end_date
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
