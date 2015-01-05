require 'bundler'

Bundler.require

require 'yaml'

#Set current file folder path to the $LOAD_PATH
$: << File.expand_path(File.dirname(__FILE__))

#load global config file
CONFIG = YAML.load_file('conf/config.yml')

#Connect to Postgresql service
DB = Sequel.connect(CONFIG['dbconnect'])
Sequel.database_timezone = :utc

#load all base module files under app folder, load sequence is important modelmodule > routebase
require 'app/models/modelmodule'
require 'app/routes/routebase'
require 'app/routes/api/apimodule'
require 'app/routes/page/pagemodule'

module SinatraWeb
    class App < Sinatra::Application

        configure do 
            #set :bind, '0.0.0.0'
            set :port, CONFIG['sinatraport']
            set :root, App.root #used to construct the default :public_folder
            disable :method_override #disable the POST _method hack
        end
        
        use Rack::Deflater
        use Rack::Session::Pool, :expire_after => 7200

        #declare Page Classes
        use SinatraWeb::Page::LoginPage
        use SinatraWeb::Page::HomePage
        
        #declare API Classes
        use SinatraWeb::RestAPI::WPTAPI
    end
end