class Antispam
  def initialize memory_path="antispam-memory"
    bayes = Classifier::Bayes.new :spam, :content
    @madeleine = SnapshotMadeleine.new(memory_path) {bayes}
    @bayes = @madeleine.system
  end

  def is_spam? submission
    @bayes.classify(submission.text) == :spam
  end

  def switch_to_spam submission
    @bayes.untrain(:content, "#{submission.title} #{submission.description}")
    @bayes.train(:spam, "#{submission.title} #{submission.description}")
    @madeleine.take_snapshot
  end

  def train_as_content submission
    @bayes.train :content, "#{submission.title} #{submission.description}"
    @madeleine.take_snapshot
  end

  def trained_entries
    @bayes.instance_variable_get :@total_words
  end
end
