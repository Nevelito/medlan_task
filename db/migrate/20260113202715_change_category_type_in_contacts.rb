class ChangeCategoryTypeInContacts < ActiveRecord::Migration[8.1]
  def change
    # for now, database has 2 records and all category values are nil so execute SQL code to migrate data is not necessary
    remove_column :contacts, :category, :string
    add_column :contacts, :category, :integer, default: 0, null: false
  end
end
