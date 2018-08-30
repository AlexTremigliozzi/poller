class Selection < ActiveRecord::Base
    has_many :post_selections
    has_many :posts, :through => :post_selections



    def average_vote
        self.cached_votes_total.to_f == 0 ? 0 : (self.cached_weighted_score.to_f / self.cached_votes_total.to_f).round(2)
    end

    def vote_status
        if self.cached_votes_total > 0
            {
                votes: get_positives.count == 0 ? "no" : self.get_positives.count,
                cached_weighted_score: self.cached_weighted_score ,
                cached_votes_total: self.cached_votes_total,
                average_vote: self.average_vote
            }
        else
            {
                votes: "no",
                cached_weighted_score: 0,
                cached_votes_total: 0,
                average_vote: 0
            }
        end
    end

end

