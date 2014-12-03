class Users::RegistrationsController <  Devise::RegistrationsController
  layout 'application'

   def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)

    result = resource.update(resource_params)


    # standart devise behaviour
    if result
      if is_navigational_format?
        if resource.respond_to?(:pending_reconfirmation?) && resource.pending_reconfirmation?
          flash_key = :update_needs_confirmation
        end
        set_flash_message :notice, flash_key || :updated
      end
      sign_in resource_name, resource, :bypass => true
      respond_with resource, :location => after_update_path_for(resource)
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  private

  def resource_params
    params.require(:user).permit(:email, :password, :password_confirmation, :avatar_url)
  end

end