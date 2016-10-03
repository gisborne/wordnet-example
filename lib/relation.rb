class Relation < Node
  def initialize(type, type_name, synset)
    @type      = type
    @type_name = type_name
    @synset    = synset
  end
end
