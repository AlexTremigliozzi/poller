class PostSelection < ActiveRecord::Base

    belongs_to :post
    belongs_to :selection

    attr_accessor :configure


end
