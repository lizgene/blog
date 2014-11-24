class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:google_oauth2]

  has_many :posts

  # def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
  #   data = access_token.info
  #   user = User.where(:email => data["email"]).first

  #   user
  # end


  #devise oauth reference - https://github.com/plataformatec/devise/wiki/OmniAuth:-Overview
  def self.from_omniauth(auth)
    #TODO
    #save token as single_user_access_token
    #token="ya29.yAD0VvX8-I3B_du_rjy-JBtSuHrsjO1q6_lOXbs1uhz8ijVhWItg5MgHo4LnFJ_91FjR6l3idCHp9A"
    #it comes back in the auth hash
    #then communicate with picasa using that token
    #client = Picasa::Client.new(user_id: "#{User.last.email}", authorization_header: "Bearer ya29.yAD0VvX8-I3B_du_rjy-JBtSuHrsjO1q6_lOXbs1uhz8ijVhWItg5MgHo4LnFJ_91FjR6l3idCHp9A")
    #client.photo.create("5628141515208460705", file_path: "app/assets/images/bird.png")
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      # user.name = auth.info.name   # assuming the user model has a name
      # user.image = auth.info.image # assuming the user model has an image
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.google_data"] && session["devise.google_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

end
