##
# Middleware for redirecting from / to /index.html.
#
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
use Rack::Auth::Basic, "EF" do |username, password|
  'secret' == password
end
run lambda{ |env| [200, {"Content-type" => "text/html"}, []] }
