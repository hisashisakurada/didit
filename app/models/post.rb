class Post < ApplicationRecord
  belongs_to :user
  
  validates :menu, presence: true, length: { maximum:125 }

  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites
end
