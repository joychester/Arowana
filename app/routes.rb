module SinatraWeb
    module Routes
        autoload :RouteBase, 'app/routes/routebase'
        
        #lazy load pages routes
        autoload :LoginPage, 'app/routes/page/loginpage'
        autoload :HomePage, 'app/routes/page/homepage'
        
        #lazy load API routes
        autoload :WPTAPI, 'app/routes/api/wptapi'
        
        #lazy load user model
        autoload :User, 'app/models/user'
    end
end