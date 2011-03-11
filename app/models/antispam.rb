class Antispam
  def create_spam_filter
    bayes = Classifier::Bayes.new :spam, :content
    madeleine = SnapshotMadeleine.new("antispam-memory") { bayes }
    madeleine.take_snapshot 
    madeleine
  end

  def initialize memory_path="antispam-memory"
    bayes = Classifier::Bayes.new :spam, :content
    @madeleine = SnapshotMadeleine.new(memory_path) {bayes}
  end

  def is_spam? submission
    @madeleine.system.classify(submission.text) == :spam
  end

  def train_as_spam submission
    @madeleine.system.train :spam, "#{submission.title} #{submission.description}"
    @madeleine.take_snapshot
  end

  def trained_entries
    @madeleine.system.instance_variable_get :@total_words
  end
end
