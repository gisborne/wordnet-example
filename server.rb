class String
  def underscore
    self.gsub(/::/, '/').
        gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2').
        gsub(/([a-z\d])([A-Z])/, '\1_\2').
        tr("-", "_").
        downcase
  end

  def camelize
    split('_').map { |w| w.capitalize }.join
  end
end

class Link
  attr_accessor :descr, :fn

  def initialize descr, fn
    @descr = descr
    @fn    = fn
  end
end

class Node
  class << self
    @links = {}

    def register(descr, link, fn)
      @links[link] = Link.new(descr, fn)
    end

    def from_req(req)
      from_path(req.path)
    end
  end

  def render
    f   = File.read("templates/#{self.class.to_s.underscore}.html.erb")
    erb = ERB.new(f)
    erb.result(binding)
  end

  def render_link
    f   = File.read("templates/#{self.class.to_s.underscore}_link.html.erb")
    erb = ERB.new(f)
    erb.result(binding)
  end

  def layout
    'layout'
  end
end

require 'rack'
require 'wordnet'
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

app = Proc.new do |env|
  req      = Rack::Request.new(env)
  req_word = req.path.split('/')[1]
  if /^_(.*)/ =~ req_word
    thing = Kernel.const_get($1.camelize).from_req(req)
  else
    thing = Word.new(req_word)
  end

  begin
    ['200', {'Content-Type' => 'text/html'}, [Layout.new(thing).render]]
  rescue Redirect => r
    res = Rack::Response.new
    res.redirect(r.target)
    res.finish
  end
end

Rack::Handler::WEBrick.run app
