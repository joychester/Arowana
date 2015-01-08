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

require 'util/reflection'

module SinatraWeb
    
    class App < Sinatra::Application
        
        include Reflection
        
        configure do 
            #set :bind, '0.0.0.0'
            set :port, CONFIG['sinatraport']
            set :root, App.root #used to construct the default :public_folder
            disable :method_override #disable the POST _method hack
        end
        
        use Rack::Deflater
        use Rack::Session::Pool, :expire_after => 7200

        #declare/register Page Module for Rack middleware, check middleware.to_s
        #example: use SinatraWeb::Page::LoginPage
         
        page_route_dir = App.root + '/app/routes/page'
        
        Resolver.get_rb_filepath_recursive(page_route_dir).each { |filepath|
            Resolver.get_file_class_name(filepath).each { |klassname|
                begin
                    use Object.const_get('SinatraWeb::Page::' + klassname)
                rescue Exception => msg   
                    puts "WARN: #{msg}"
                end
            }
        }
        
        #declare/register Page Module for Rack middleware, check middleware.to_s
        #example: use SinatraWeb::RestAPI::WPTAPI
        api_route_dir = App.root + '/app/routes/api'
        
        Resolver.get_rb_filepath_recursive(api_route_dir).each { |filepath|
            Resolver.get_file_class_name(filepath).each { |klassname|
                begin
                    use Object.const_get('SinatraWeb::RestAPI::' + klassname)
                rescue Exception => msg   
                    puts "WARN: #{msg}"
                end
            }
        }
       
    end
    
end