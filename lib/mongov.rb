require 'lib/view_helpers'

set :views , File.join( File.dirname(__FILE__), %w[views] )
set :public, File.join( File.dirname(__FILE__), %w[public] )

enable :sessions

PER_PAGE = 25

before do
  begin
    @mongo = Mongo::Connection.new
  rescue Mongo::ConnectionFailure
    @mongo = nil
  end
end

get '/?' do
  return erb :error if @mongo.nil?
  @databases = @mongo.database_info
  erb :index
end

get '/:db/?' do
  @database     = @mongo.db(params[:db])
  @collections  = @database.collection_names
  erb :database
end

delete '/:db/:collection/?*' do
  @database   = @mongo.db(params[:db])
  @collection = @database[params[:collection]].drop
  session[:message] = "Collection #{params[:collection]} dropped!"
  redirect "/#{params[:db]}"
end

get '/:db/:collection/?*' do
  @page = page
  skip = (@page - 1) * PER_PAGE

  @database   = @mongo.db(params[:db])
  @collection = @database[params[:collection]]
  @documents  = @collection.find({}, {:limit => PER_PAGE, :skip => skip})

  @pages = (@collection.size / PER_PAGE ) + 1
  erb :collection
end

def page
  params[:splat][0] = 1 if params[:splat][0].empty? or params[:splat][0] == "0"
  params[:splat][0].to_i
end
