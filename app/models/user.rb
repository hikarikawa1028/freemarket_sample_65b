class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  before_save { self.email = email.downcase }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :nickname, :birthday, presence: true
  validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: "は@とドメインを含んだものを入力してください" }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, format: { with: /\A[a-zA-Z0-9]+\z/, message: "は半角英数字で入力してください"}, length: { minimum: 7 }
  validates :family_name, :first_name, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]/, message: "は全角で入力してください"}
  validates :family_name_kana, :first_name_kana, presence: true, format: { with: /\A[ぁ-ん]+\z/, message: "は全角ひらがなで入力してください"}

  has_one :address
  has_many :creditcards
  has_many :items
  has_many :images
end
