require 'util/reflection'

module SinatraWeb
    module RestAPI
        
        dirname = File.expand_path(File.dirname(__FILE__))
        
        include Reflection
        
        Resolver.get_rb_filepath_recursive(dirname).each { |filepath|
            Resolver.get_file_class_name(filepath).each { |klassname|
                # lazy load API routes, autoload is discouraged by Matz...
                # format "autoload :WPTAPI, 'app/routes/api/wptapi.rb"
                autoload klassname.to_sym, filepath
            }
        }

        class BaseAPI < SinatraWeb::Routes::RouteBase
            #todo
        end
    end
end
