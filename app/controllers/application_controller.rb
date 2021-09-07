  class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters,if: :devise_controller?
    
    def after_sign_up_path_for(resource)
      if current_user
        flash[:notice] = "正常にログインできました！いい出会いを＾＾"
        homes_about_path
      end
    end
    
    def after_sign_in_path_for(resource)
      users_path
    end
  
  
  
    protected
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up,keys: [:name,:age,:adderss,:profile_image_id,
      :sex,:playing_game,:introduction])
    end
    
  end