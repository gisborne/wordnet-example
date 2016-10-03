class Words < Node
  include Enumerable

  def initialize(words)
    @words = words
  end

  def each
    @words.each { |w| yield Word.new(w) }
  end
end
