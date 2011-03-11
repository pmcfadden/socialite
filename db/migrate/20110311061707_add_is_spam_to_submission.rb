class AddIsSpamToSubmission < ActiveRecord::Migration
  def self.up
    add_column :submissions, :is_spam, :boolean
  end

  def self.down
    remove_column :submissions, :is_spam
  end
end
