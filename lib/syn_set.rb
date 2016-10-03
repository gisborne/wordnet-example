class SynSet < Node
  def self.from_path(path)
    path_parts = path.split('/')
    pos        = path_parts[2]
    offset     = path_parts[3]
    new(WordNet::Synset.new(pos, offset.to_i))
  end


  def initialize(wn_synset)
    @synset = wn_synset
  end

  %i{antonyms hyponyms hypernyms}.each do |m|
    define_method m do
      Synsets.new(@synset.send(m))
    end
  end

  def antonyms
    Synsets.new(@synset.antonyms)
  end

  def all_relations
    relations = relations_for_this.map do |k, v|
      things = relation(k) rescue nil
      if things && (things.count > 0)
        Relation.new(k, v, Synsets.new(things))
      end
    end.compact
    Relations.new(relations)
  end

  def relations_for_this
    {
        'n' => WordNet::NOUN_POINTERS,
        'v' => WordNet::VERB_POINTERS,
        'a' => WordNet::ADJECTIVE_POINTERS,
        'r' => WordNet::ADVERB_POINTERS,
    }[synset_type]
  end

  def method_missing kw, *args
    @synset.send kw, *args
  end
end
