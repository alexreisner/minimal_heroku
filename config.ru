class App
  def call(env)
    file = env['REQUEST_PATH']
    file = "/index.html" if file == "/"
    filepath = ::File.dirname(__FILE__) + "/public" + file
    if ::File.exist? filepath
      Rack::File.new(filepath).call(env)
    else
      [404, {"Content-type" => "text/html"}, ""]
    end
  end
end

run App.new
