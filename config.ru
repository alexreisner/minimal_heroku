# alternate version of bare rack app using lambda
run lambda{ |env| [200, {"Content-type" => "text/html"}, env.inspect] }

