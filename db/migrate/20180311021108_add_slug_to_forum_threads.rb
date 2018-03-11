class AddSlugToForumThreads < ActiveRecord::Migration
  def change
    add_column :forum_threads, :slug, :string
  end
end
