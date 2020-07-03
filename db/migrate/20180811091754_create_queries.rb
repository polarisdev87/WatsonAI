class CreateQueries < ActiveRecord::Migration[5.2]
  def change
    create_table :queries do |t|
      t.numeric :user_id, null: false
      t.text :query, null: false
      t.string :total_count,  null: false, default: ""
      t.timestamps
    end
  end
end
