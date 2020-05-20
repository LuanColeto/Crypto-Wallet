module ApplicationHelper
    def date_br(date_us)
        date_us.strftime("%d/%m/%Y")
    end
    def enviroment
        if Rails.env == "development"
            "Desenvolvimento"
        end
    end
    def locale_set
        I18n.locale == :en ? "Estados Unidos" : "Brasil"
    end
end
