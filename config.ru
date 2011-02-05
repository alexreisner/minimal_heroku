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

use Rack::Auth::Basic, "Fa11" do |username, password|
  username == ENV['demo_username'] and password == ENV['demo_password']
end
use RedirectRootUrl
use Rack::Static, :urls => ['/'], :root => "public"
run lambda{ |env| [200, {"Content-type" => "text/html"}, []] }
