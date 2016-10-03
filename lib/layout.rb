class Layout < Node
  def initialize(content)
    @content = content
  end

  def render
    f   = File.read("templates/#{@content.layout}.html.erb")
    erb = ERB.new(f)
    erb.result(binding)
  end

  def render_content
    @content.render
  end
end
