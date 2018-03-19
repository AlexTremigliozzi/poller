class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

    has_many :votes, dependent: :destroy
    has_many :vote_options, through: :votes
    has_many :posts
    has_many :comments

    has_paper_trail

    include Oauth51Client::User

     def self.from_omniauth(auth)
       random_psw = Devise.friendly_token[0,20]

       this_user = where(o51_uid: auth.uid).first_or_initialize do |user|
         user.email = auth.info.email
         user.password = random_psw
         user.password_confirmation = random_psw
       end

       # Let's apply fresh data
       this_user.o51_authentication_token = auth.credentials.token
       this_user.o51_authentication_token_secret = auth.credentials.refresh_token
       this_user.o51_expires_at = (Time.at(auth.credentials.expires_at) rescue nil)

       # o51_client is defined in oauth51-client gem
       profile = this_user.o51_client.me
       this_user.o51_points = profile['points']
       this_user.o51_picture_url = profile['avatar_url']
       this_user.o51_authentication_token = auth.credentials.token
       this_user.o51_authentication_token_secret= auth.credentials.refresh_token
       this_user.o51_profile = profile.to_json
       this_user.save
       this_user
     end

    def voted_for?(poll)
      vote_options.any? {|v| v.poll == poll }
    end

    # def voted_for?(poll)
    #   votes.any? {|v| v.vote_option.poll == poll}
    # end

    # def voted_for?(poll)
    #   vote_options(true).any? {|v| v.poll == poll }
    # end

end
