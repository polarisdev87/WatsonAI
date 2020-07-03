class AddModuleType < ActiveRecord::Migration[5.2]
  def change
    change_table :queries do |t|

      t.string :module_type,  null: false, default: ""


    end
  end
end
