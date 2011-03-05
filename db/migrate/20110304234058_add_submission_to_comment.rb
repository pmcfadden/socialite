class AddSubmissionToComment < ActiveRecord::Migration
  def self.up
    add_column :comments, :submission_id, :integer
  end

  def self.down
    remove_column :comments, :submission_id
  end
end
