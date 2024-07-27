# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
Admin.create!(
   email: 'aaa@aaa',
   name: 'aaaa',
   password: "#{ENV['ADMIN_KEY']}"
)
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

olivia = User.find_or_create_by!(email: "olivia@example.com") do |user|
  user.name = "Olivia"
  user.password = "password"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user1.jpg"), filename:"sample-user1.jpg")
end

james = User.find_or_create_by!(email: "james@example.com") do |user|
  user.name = "James"
  user.password = "password"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user2.jpg"), filename:"sample-user2.jpg")
end

lucas = User.find_or_create_by!(email: "lucas@example.com") do |user|
  user.name = "Lucas"
  user.password = "password"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user3.jpg"), filename:"sample-user3.jpg")
end

PostImage.find_or_create_by!(title: "Cavello") do |post_image|
  post_image.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post11.jpg"), filename:"sample-post11.jpg")
  post_image.body = "大人気のカフェです。"
  post_image.address = "東京都千代田区丸の内1丁目" # 追記
  post_image.user = olivia
end

PostImage.find_or_create_by!(title: "和食屋せん") do |post_image|
  post_image.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post12.jpg"), filename:"sample-post12.jpg")
  post_image.body = "日本料理は美しい！"
  post_image.address = "愛知県名古屋市中村区名駅１丁目１−４" # 追記
  post_image.user = james
end

PostImage.find_or_create_by!(title: "ShoreditchBar") do |post_image|
  post_image.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post13.jpg"), filename:"sample-post13.jpg")
  post_image.body = 'メキシコ料理好きな方にオススメ！'
  post_image.address = "大阪府大阪市淀川区西中島5-16-1" # 追記
  post_image.user = lucas
end