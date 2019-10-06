class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.references :participant, foreign_key: true
      t.datetime :date
      t.string :message

      t.timestamps
    end
  end
end
