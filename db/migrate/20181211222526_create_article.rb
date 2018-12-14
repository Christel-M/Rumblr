class CreateArticle < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |art|
      art.string :title
      art.text :content
      art.string :image
      art.integer :user_id
      art.boolean :published, :default => false
      art.datetime :published_on, :required => false
      art.timestamps null: false
    end
  end
end
