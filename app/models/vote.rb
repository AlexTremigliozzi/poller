class Vote < ActiveRecord::Base
    has_paper_trail
    belongs_to :user
    belongs_to :vote_option
end
