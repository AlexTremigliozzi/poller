class Post < ActiveRecord::Base
  has_paper_trail
  acts_as_commentable
  belongs_to :user
  after_create :set_selection_indices
  # has_many :comments
  has_many :category_posts, dependent: :destroy
  has_many :categories, :through => :category_posts

  has_many :post_selections
  has_many :selections, :through => :post_selections

  def mentions
    @mentions ||= begin
      regex = /@([\w]+)/
      description.scan(regex).flatten
    end
  end

  def mentioned_users
    @mentioned_users ||= User.where(name: mentions)
  end


  acts_as_commentable


  def set_selection_indices
    _selection_indices = Selection.where(post_id: nil)

    _selection_indices.each do | _selection_index |
      Selection.create!({name: _selection_index.name, post_id: self.id, description: _selection_index.description})
    end
  end


end
