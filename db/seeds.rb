# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

@@text = %{The IMF's influence in the global economy steadily increased as it accumulated more members. The number of IMF member countries has more than quadrupled from the 44 states involved in its establishment, reflecting in particular the attainment of political independence by many developing countries and more recently the collapse of the Soviet bloc. The expansion of the IMF's membership, together with the changes in the world economy, have required the IMF to adapt in a variety of ways to continue serving its purposes effectively.}

def create_users
  users = ["john", "mike", "paul", "betty", "ashley"].map do |username|
    john = {:username => username, :email => "#{username}@example.com", :password => '123456', :karma => rand(500)}
  end

  User.create(users)
end

def random_text
  words = @@text.split
  first = rand(words.size - 15)
  last = rand(15)
  words[first, last].join " "
end

def create_submissions
  50.times do
    Submission.create([{:url => random_text, :title => random_text, :description => random_text, :created_at => rand(2400).minutes.ago, :score => rand(50), :user => User.find(rand(User.all.size) + 1)}])
  end
end

create_users
create_submissions



