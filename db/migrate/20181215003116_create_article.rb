class CreateArticle < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |art|
      art.belongs_to :user
      art.string :title
      art.text :content
      art.string :image
      art.integer :user_id
      art.string :hashtags
      art.datetime :created_at
    end
  end
end
