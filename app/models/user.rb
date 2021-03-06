class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 20}
  validates :email, presence: true, length: { maximum: 50},
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  
  mount_uploader :image, ImageUploader
  has_secure_password
  

  has_many :posts

  has_many :favorites
  has_many :favposts, through: :favorites, source: :post
  
  def feed_posts
    Post.where(user_id: self.id)
  end
  
  def like(post)
    favorites.find_or_create_by(post_id: post.id)
  end

  def unlike(post)
    favorite = favorites.find_by(post_id: post.id)
    favorite.destroy if favorite
  end

  def  favpost?(post)
    self.favposts.include?(post)
  end
  
end
