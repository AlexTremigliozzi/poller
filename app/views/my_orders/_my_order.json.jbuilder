json.extract! my_order, :id, :data1, :data2, :data3, :name, :desc, :created_at, :updated_at
json.url my_order_url(my_order, format: :json)
