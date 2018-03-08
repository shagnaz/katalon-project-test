class CreateForumPosts < ActiveRecord::Migration
  def change
    create_table :forum_posts do |t|
      t.text :content
      t.integer :forum_thread_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
