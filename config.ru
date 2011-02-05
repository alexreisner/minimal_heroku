class RedirectRootUrl
  def initialize(app)
    @app = app
  end
 
  def call(env)
    # execute the request using our Rails app
   status, headers, body = @app.call(env)
 
    if status == 404 and env['REQUEST_PATH'] == '/'
      [302, {"Location" => "index.html"}, []]
    else
      [status, headers, body]
    end
  end
end

use RedirectRootUrl
use Rack::Static, :urls => ['/'], :root => "public"

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
