# Any Sample project Rest APIs locates here
module SinatraWeb
    module Routes
        class WPTAPI < RouteBase
            
            get '/rest/wptresult' do 
	            return 'service is ready for use!'
            end
            
        end
    end
end