module SinatraWeb
    module Routes
        class HomePage < RouteBase
            
            get '/home' do
                # Pass session data to haml file by @param
                @login_name = session[:loginuser]
                haml :home
            end
            
        end
    end
end