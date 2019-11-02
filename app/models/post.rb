class Post < ApplicationRecord
  belongs_to :user
  
  validates :menu, presence: true, length: { maximum:125 }
  validates :weight, presence: true, :numericality => { :greater_than_or_equal_to => 0 } 
  validates :counts, presence: true, :numericality => { :greater_than_or_equal_to => 1 } 
  validates :set, presence: true, :numericality => { :greater_than_or_equal_to => 1 } 

  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites
end
