module SinatraWeb
    module Page
        
        #lazy load pages routes, discouraged by Matz...
        autoload :LoginPage, 'app/routes/page/loginpage'
        autoload :HomePage, 'app/routes/page/homepage'
        
        class BasePage < SinatraWeb::Routes::RouteBase
            #todo
        end
    end
end