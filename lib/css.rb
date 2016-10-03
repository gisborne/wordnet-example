class Css < Node
  def self.from_path(path)
    new
  end

  def render
    File.read('css/bootstrap.css')
  end

  def layout
    'blank'
  end
end
