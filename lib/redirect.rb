class Redirect < Exception
  attr_accessor :target

  def initialize(target)
    @target = target
  end
end
