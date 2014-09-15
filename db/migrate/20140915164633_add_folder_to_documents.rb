class AddFolderToDocuments < ActiveRecord::Migration
  def change
    add_reference :documents, :folder, index: true
  end
end
