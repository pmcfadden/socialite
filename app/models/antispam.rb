class Antispam
  def initialize memory_path="antispam-memory"
    bayes = Classifier::Bayes.new :spam, :content
    @madeleine = SnapshotMadeleine.new(memory_path) {bayes}
    @bayes = @madeleine.system
  end

  def is_spam? stringable
    compute_uncertainty(stringable) > 1 and @bayes.classify(submission.to_s) == 'Spam'
  end

  def switch_to_spam stringable
    @bayes.untrain(:content, stringable.to_s)
    @bayes.train(:spam, stringable.to_s)
    @madeleine.take_snapshot
  end

  def train_as_content stringable
    @bayes.train :content, stringable.to_s
    @madeleine.take_snapshot
  end

  def trained_entries
    @bayes.instance_variable_get :@total_words
  end

  def compute_uncertainty stringable
    scores = @bayes.classifications(stringable.to_s)
    sorted_scores = scores.sort_by{ |a| -a[1] }
    delta = sorted_scores[1][1].abs - sorted_scores[0][1].abs
    Rails.logger.info "The classifier thinks stringable '#{stringable}' is '#{sorted_scores[0][0]}' with a certainty of #{delta}"
    delta.nan? ? 0 : delta
  end

end
