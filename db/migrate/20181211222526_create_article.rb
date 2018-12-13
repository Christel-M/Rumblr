class CreateArticle < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |art|
      art.string :title
      art.text :content
      art.string :image
      art.integer :user_id
    end
  end
end
