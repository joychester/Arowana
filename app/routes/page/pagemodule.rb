require 'util/reflection'

module Arowana
    module Page
        
        dirname = File.expand_path(File.dirname(__FILE__))
        
        include Reflection
        
        Resolver.get_rb_filepath_recursive(dirname).each { |filepath|
            Resolver.get_file_class_name(filepath).each { |klassname|
                # lazy load pages routes, autoload is discouraged by Matz...
                # format "autoload :LoginPage, 'app/routes/page/loginpage.rb'"
                autoload klassname.to_sym, filepath
            }
        }
        
        class BasePage < Arowana::Routes::RouteBase
            
            #logout route is used across all pages
            get '/logout' do
                #remove the session data
                session[:loginuser] = nil
                redirect "/login"
            end
            
        end
    end
end