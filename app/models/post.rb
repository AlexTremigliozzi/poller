class Post < ActiveRecord::Base
  has_paper_trail
  acts_as_commentable
  belongs_to :user
  # has_many :comments
  has_many :category_posts, dependent: :destroy
  has_many :categories, :through => :category_posts

  def mentions
    @mentions ||= begin
      regex = /@([\w]+)/
      description.scan(regex).flatten
    end
  end

  def mentioned_users
    @mentioned_users ||= User.where(name: mentions)
  end


end
