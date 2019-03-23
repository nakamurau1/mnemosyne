module SessionsHelper
    def login(user)
        session[:user_id] = user.id
    end

    def log_out
        if session.delete(:user_id)
            @current_user = nil
        end
    end

    def current_user
        return nil unless session[:user_id]
        @current_user ||= User.find_by(id: session[:user_id])
    end

    def logged_in?
        current_user.present?
    end
end
