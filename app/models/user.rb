class User < ApplicationRecord
  has_one  :profile
  has_many :items
  has_many :sendings, dependent: :destroy
  has_many :cards, dependent: :destroy
  has_many :comments
  has_many :likes, dependent: :destroy
  has_many :items, through: :likes
  has_many :orders

  def already_liked?(item)
    self.likes.exists?(item_id: item.id)
  end
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  with_options presence: true do
    validates :nickname, uniqueness: true, length: { maximum: 8 }
    validates :email, uniqueness: true 
    validates :birth_year
    validates :birth_month
    validates :birth_day
  end

  with_options format: {with: /\A[ぁ-んァ-ン一-龥]/} do
    validates :firstname
    validates :lastname
  end
  with_options format: {with: /\A[ぁ-んー－]+\z/} do
    validates :firstname_kana
    validates :lastname_kana
  end
end