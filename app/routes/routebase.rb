module SinatraWeb
    module Routes
        class RouteBase < Sinatra::Application
            configure do
                set :views, 'app/views'
                set :root, App.root
            end
        end
    end
end
