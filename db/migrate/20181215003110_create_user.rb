class CreateUser < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |usr|
      usr.string :firstname
      usr.string :lastname
      usr.string :email
      usr.string :password
      usr.date :dob
    end
  end
end
