class Synsets < Node
  include Enumerable

  def initialize(synsets)
    @synsets = synsets
  end

  def each
    @synsets.each { |l| yield l }
  end
end
