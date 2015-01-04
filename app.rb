require 'bundler'

Bundler.require

require 'yaml'

#load current file folder path to the $LOAD_PATH
$: << File.expand_path(File.dirname(__FILE__))

#load skeleton.rb file under app folder
require 'app/routes'

#load global config file
CONFIG = YAML.load_file('conf/config.yml')

#Connect to Postgresql DB
DB = Sequel.connect(CONFIG['dbconnect'])
Sequel.database_timezone = :utc

module SinatraWeb
    class App < Sinatra::Application
        
        configure do 
            #set :bind, '0.0.0.0'
            set :port, CONFIG['sinatraport']
            disable :method_override
            disable :static
        end
        
        use Rack::Deflater
        use Rack::Session::Pool, :expire_after => 7200
        
        use SinatraWeb::Routes::LoginPage
        use SinatraWeb::Routes::HomePage
        
        use SinatraWeb::Routes::WPTAPI
    end
end