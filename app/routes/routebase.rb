
module SinatraWeb
    module Routes

        class RouteBase < Sinatra::Application

            configure do
                set :views, 'app/views'
            end
        end
    end
end
