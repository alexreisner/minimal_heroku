class App
  def call(env)
    file = env['REQUEST_PATH']
    file = "/index.html" if file == "/"
    filepath = "public" + file
    if File.exist? filepath
      [200, {"Content-type" => "text/html"}, File.read(filepath)]
    else
      [404, {"Content-type" => "text/html"}, ""]
    end
  end
end

run App.new
