class RenamePhoneToPhoneNumberInUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :phone
    add_column :users, :phone_number, :string, null: false, default: ""
  end
end
