class Lemmas < Node
  include Enumerable

  def initialize(word)
    @word = word
  end

  def each
    WordNet::Lemma.find_all(@word).each { |l| yield l }
  end

  def render
    forms = to_a
    forms.map do |l|
      Form.new(l).render_link
    end * '<br>'
  end
end
