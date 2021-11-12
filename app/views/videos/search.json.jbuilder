json.array! @videos do |video|
  json.title video.title
  json.user_id video.user_id
  json.id video.id
  json.introduction
  json.user_sign_in current_user
end