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
                saved_pwd = result[:pwd]
                
                if input_pwd == saved_pwd
                    session[:loginuser] = input_uname
                    return "allowed";
                elsif input_pwd != saved_pwd
                    return "refused"
                else
                    # return nil
                    return "nothing"
                end
            end
            
        end
    end
end
