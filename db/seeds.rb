# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

# random text taken from wikipedia
@@text = %{The IMF's influence in the global economy steadily increased as it accumulated more members. The number of IMF member countries has more than quadrupled from the 44 states involved in its establishment, reflecting in particular the attainment of political independence by many developing countries and more recently the collapse of the Soviet bloc. The expansion of the IMF's membership, together with the changes in the world economy, have required the IMF to adapt in a variety of ways to continue serving its purposes effectively.}

def random_text
  words = @@text.split
  first = rand(words.size - 16)
  length = rand(15) + 1
  words[first, length].join " "
end

def random_user
  User.find(rand(User.all.size) + 1)
end

def create_users
  users = "john mike paul betty ashley ricky jane minnie mickey sally harry hermione tom slim jim colin smith gordon gunther emily veronica ed al matt henry bob richard sandra lizzie deborah barbie".split.map do |username|
    {:username => username, :email => "#{username}@example.com", :password => '123456', :karma => (rand(500) + 1)}
  end

  User.create!(users)
  User.all.first.update_attribute :admin, true
  User.all[1,6].each {|user| user.update_attribute :deleted, true }
end

def create_submissions
  default_sub = lambda {{:url => "example.com", :title => random_text, :description => random_text, :created_at => rand(2400).minutes.ago, :score => rand(50), :user => random_user}}
  50.times do
    Submission.create!([default_sub.call.merge :is_spam => false])
  end
  3.times do
    Submission.create!([default_sub.call.merge :is_spam => true])
  end
end

def create_comments
  Submission.all.each do |submission|
    rand(4).times do
      comment = Comment.create!([{:submission => submission, :text => random_text, :user => random_user}]).first
      if rand(2) == 0
        Comment.create!([{:parent => comment, :submission => submission, :text => random_text, :user => random_user}])
      end
    end
  end
end

create_users
create_submissions
create_comments

