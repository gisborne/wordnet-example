class Form < Node
  def initialize(lemma)
    @wn_lemma = lemma
  end

  def method_missing meth, *args
    @wn_lemma.send meth, *args
  end
end
