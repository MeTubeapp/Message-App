json.extract! message, :id, :title, :caption,:image, :user_id, :created_at, :updated_at
json.url message_url(message, format: :json)
