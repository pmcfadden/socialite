require 'rubygems'
require 'classifier'
require 'madeleine'

def create_spam_filter
  bayes = Classifier::Bayes.new :spam, :content
  bayes.train :spam, 'viagra sex free'
  bayes.train :spam, 'you should buy these powders'
  bayes.train :spam, 'Do you want to experience happiness?'
  bayes.train :spam, 'I found out something really amazing!'
  bayes.train :content, 'Things I want to talk about'
  bayes.train :content, 'Good article about the IMF'
  bayes.train :content, 'I thought the author had a good point'
  bayes.train :content, 'What do you guys think of this one?'

  madeleine = SnapshotMadeleine.new("antispam-memory") { bayes }
  madeleine.take_snapshot 
  madeleine
end

def load_spam_filter
  madeleine = SnapshotMadeleine.new("antispam-memory")
end

def classify text
  scores = load_spam_filter.system.classifications text
  raise "the classifier needs at least two categories" if scores.size < 2

  sorted_scores = scores.sort_by{ |a| -a[1] }
  delta = sorted_scores[1][1].abs - sorted_scores[0][1].abs

  puts "the classifier says '#{sorted_scores[0][0]}' with a certainty of #{delta}"
end

def iclassify text
  classify text
  puts "Was that spam? (Y or N)"
  answer = gets
  if !answer.nil? and answer.upcase =~ /^Y/
    madeleine = load_spam_filter
    madeleine.system.train :spam, text
    madeleine.take_snapshot

    "The classifier was trained. It will be better next time."
  end
end
