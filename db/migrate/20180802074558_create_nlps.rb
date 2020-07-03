class CreateNlps < ActiveRecord::Migration[5.2]
  def change
    create_table :nlps do |t|

      t.timestamps
    end
  end
end
