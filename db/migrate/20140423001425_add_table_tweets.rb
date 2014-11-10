class AddTableTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :content
      t.boolean :public
      t.integer :user_id
      t.timestamps
    end
  end
end
