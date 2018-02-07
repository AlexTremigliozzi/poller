namespace :bot do
  desc "Prova di cron_job"
  task post_bot: :environment do
    post = Post.new
    post.title = "Post delle #{Time.now}"
    post.description = "Descrizione delle #{Time.now}"
    post.save
  end

end
