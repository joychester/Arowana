module SinatraWeb
    module RestAPI
        
        #lazy load API routes
        autoload :WPTAPI, 'app/routes/api/wptapi'
        
        class BaseAPI < SinatraWeb::Routes::RouteBase
            #todo
        end
    end
end
