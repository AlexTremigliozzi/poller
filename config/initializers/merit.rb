# Use this hook to configure merit parameters
Merit.setup do |config|
  # Check rules on each request or in background
  # config.checks_on_each_request = true

  # Define ORM. Could be :active_record (default) and :mongoid
  # config.orm = :active_record

  # Add application observers to get notifications when reputation changes.
  # config.add_observer 'MyObserverClassName'

  # Define :user_model_name. This model will be used to grand badge if no
  # `:to` option is given. Default is 'User'.
  # config.user_model_name = 'User'

  # Define :current_user_method. Similar to previous option. It will be used
  # to retrieve :user_model_name object if no `:to` option is given. Default
  # is "current_#{user_model_name.downcase}".
  # config.current_user_method = 'current_user'

  Merit::Badge.create!(
    id: 1,
    name: "Junior Blogger",
    level: 1,
    description: "Under 5 posts",
    custom_fields: { difficulty: :bronze, label: "Post", img: '/bronze.jpg' }
  )
  Merit::Badge.create!(
    id: 2,
    name: "Senior Blogger",
    level: 2,
    description: "Under 10 posts",
    custom_fields: { difficulty: :silver, label: "Post", img: '/silver.jpg' }
  )
  Merit::Badge.create!(
    id: 3,
    name: "Top Blogger",
    level: 3,
    description: "Over 10 posts",
    custom_fields: { difficulty: :gold, label: "Post", img: '/gold.jpg' }
  )
  Merit::Badge.create!(
    id: 4,
    name: "Junior Commenter",
    level: 1,
    description: "Under 5 comments",
    custom_fields: { difficulty: :bronze, label: "Comment", img: '/bronze.jpg' }
  )
  Merit::Badge.create!(
    id: 5,
    name: "Senior Commenter",
    level: 2,
    description: "Under 10 comments",
    custom_fields: { difficulty: :silver, label: "Comment", img: '/silver.jpg' }
  )
  Merit::Badge.create!(
    id: 6,
    name: "Top Commenter",
    level: 3,
    description: "Over 10 comments",
    custom_fields: { difficulty: :gold, label: "Comment", img: '/gold.jpg' }
  )

end

# Create application badges (uses https://github.com/norman/ambry)
# badge_id = 0
# [{
#   id: (badge_id = badge_id+1),
#   name: 'just-registered'
# }, {
#   id: (badge_id = badge_id+1),
#   name: 'best-unicorn',
#   custom_fields: { category: 'fantasy' }
# }].each do |attrs|
#   Merit::Badge.create! attrs
# end
