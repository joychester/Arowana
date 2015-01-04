module SinatraWeb
    module Routes
        class LoginPage < RouteBase
            
            #check if there is no session record,try login
            get '/' do 
                redirect '/login'
            end
            
            get '/login' do
                haml :login
            end
            
            post '/login' do
                input_uname = params[:username]
                input_pwd = params[:passwd]
                
                result = User.getUserByName(input_uname)
                
                if result == nil
                    return "nothing"
                elsif input_pwd == result[:pwd]
                    session[:loginuser] = input_uname
                    return "allowed";
                else
                    return "refused"
                end
            end
        end
    end
end
