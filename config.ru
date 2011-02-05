class RedirectRootUrl

  def initialize(app)
    @app = app
  end
 
  def call(env)
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
  end
end

run App.new
