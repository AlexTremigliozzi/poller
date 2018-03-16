class User < ActiveRecord::Base
  has_merit

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

    has_many :votes, dependent: :destroy
    has_many :vote_options, through: :votes
    has_many :posts
    has_many :comments

    has_paper_trail
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
