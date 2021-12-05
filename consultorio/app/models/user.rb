class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
          :rememberable, :validatable
  validates :role, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, uniqueness: false

  enum role: [:query, :assistance, :administrator]
end
