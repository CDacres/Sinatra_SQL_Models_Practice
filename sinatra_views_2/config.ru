require "sinatra"
require "sinatra/reloader" if development?
require "pg"
require_relative "./controllers/post_controller.rb"
require_relative "./models/Posts.rb"

use Rack::MethodOverride

run PostController
