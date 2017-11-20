class PostController < Sinatra::Base

	configure :development do 
		register Sinatra::Reloader
	end

	#Sets location of root directory
	set :root, File.join(File.dirname(__FILE__), "..")

	#Sets location of views
	set :views, Proc.new { File.join(root, 'views') }

	get '/posts' do
		@page_header = "All the posts"
		@posts = Post.all
		erb :"posts/index"
	end	

	get '/posts/new' do
		erb :"posts/new"
	end

	get '/posts/:id' do
		id = params[:id].to_i
		@page_header = "Show a single post"
		@post = Post.find id
		erb :"posts/show"
	end

	post "/posts" do
		new_post = Post.new
		new_post.title = params[:title]
		new_post.body = params[:body]
		new_post.save
		redirect "/posts"
	end

	get '/posts/:id/edit' do
		@post = Post.find(params[:id])
		erb :"posts/edit"
	end

	put "/posts/:id" do
		post = Post.find(params[:id])
		post.title = params[:title]
		post.body = params[:body]
		post.save
		redirect "/posts/#{post.id}"
	end

	delete "/posts/:id" do
		Post.destroy(params[:id])
		redirect "/posts"
	end

end