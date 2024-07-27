json.data do
  json.items do
    json.array!(@post_images) do |post_image|
      json.id post_image.id
      json.user do
        json.name post_image.user.name
        json.image url_for(post_image.user.profile_image)
      end
      json.image url_for(post_image.image)
      json.title post_image.title
      json.body post_image.body
      json.address post_image.address
      json.latitude post_image.latitude
      json.longitude post_image.longitude
    end
  end
end