class PostImage < ApplicationRecord
  has_one_attached :image
  validates :image, presence: true
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  #7/25API地図を使うための表記
  validates :address, presence: true

  geocoded_by :address
  after_validation :geocode

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end
  
  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}
  scope :favorite_count, -> {order(favorites: :desc)}
  
 def favorited_by?(user)
   favorites.exists?(user_id: user.id)
 end
    # 7/9 ここからPostimage検索のモデルを追加 ※変数ではなく空のモデルとして入れるとのこと
    # 更にconsent methodの定義をつける→コントローラで変数として代入する
  def self.search_for(content, method)
    if method == 'perfect'
      PostImage.where(title: content)
    elsif method == 'forward'
      PostImage.where('title LIKE ?', content+'%')
    elsif method == 'backward'
      PostImage.where('title LIKE ?', '%'+content)
    else
      PostImage.where('title LIKE ?', '%'+content+'%')
         # 7/9 ここまで
    end
  end
  
end
