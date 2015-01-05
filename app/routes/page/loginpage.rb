module SinatraWeb
    module Page
        
        class LoginPage < BasePage
            
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
                
                result = SinatraWeb::DBModel::User.getUserByName(input_uname)
                
                if result == nil
                    return "nothing"
                elsif input_pwd == result[:pwd]
                    #save username to session
                    session[:loginuser] = input_uname
                    return "allowed";
                else
                    return "refused"
                end
            end
        end
    end
end
