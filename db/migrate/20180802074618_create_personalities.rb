class CreatePersonalities < ActiveRecord::Migration[5.2]
  def change
    create_table :personalities do |t|
      t.numeric :user_id, null: false
      t.string :name,  null: false, default: ""
      t.float :sentiment,  null: false
      t.string :cat_type, null: false
      t.string :relevance, null: false
      t.string :emotion, null: false
      t.string :description, null: false
      t.string :query_id, null: false
      t.timestamps
    end
  end
end
