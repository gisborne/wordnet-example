class Js < Node
  def self.from_path(path)
    new
  end

  def render
    File.read('js/bootstrap.js')
  end

  def layout
    'blank'
  end
end
