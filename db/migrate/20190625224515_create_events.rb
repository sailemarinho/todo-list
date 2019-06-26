class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.references :task, foreign_key: true
      t.jsonb :user_data

      t.timestamps
    end
  end
end
