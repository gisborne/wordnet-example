class Find < Node
  def self.from_req(req)
    new(req)
  end

  def initialize(req)
    @req = req
  end

  def render
    raise Redirect.new("/#{@req.params['word']}")
  end
end
