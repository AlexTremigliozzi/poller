class Api::V1::PostsController < Api::V1::BaseController


  api :GET, '/posts', "Gets the filtered list of posts"
  def index

    posts = Post.where(user_id: api_current_user.id).all

    serialize_resources posts, ::V1::PostListSerializer
  end

end
