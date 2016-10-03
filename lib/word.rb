class Word < Node
  attr_accessor :word

  def initialize(word)
    @word = word
  end

  def lemmas
    Lemmas.new(word)
  end

  def render
    super
  end
end
