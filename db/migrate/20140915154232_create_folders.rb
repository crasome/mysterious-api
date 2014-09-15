class CreateFolders < ActiveRecord::Migration
  def change
    create_table :folders do |t|
      t.string :name
      t.references :owner, index: true

      t.timestamps
    end
  end
end
