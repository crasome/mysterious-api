class AddOwnerToDocuments < ActiveRecord::Migration
  def change
    add_reference :documents, :owner, index: true
  end
end
