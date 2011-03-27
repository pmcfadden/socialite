class AddCommentsCount < ActiveRecord::Migration
  def self.up
    add_column :submissions, :comments_count, :integer, :default => 0

    Submission.reset_column_information
    Submission.find(:all).each do |p|
      Submission.update_counters p.id, :comments_count => p.comments.length
    end
  end

  def self.down
    remove_column :projects, :comments_count
  end
end
