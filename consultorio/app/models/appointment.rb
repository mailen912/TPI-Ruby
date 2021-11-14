class Appointment < ApplicationRecord
  belongs_to :professional
  validates :date, presence: true
  validates :name, presence: true
  validates :surname, presence:true
  validates :phone, presence:true
  validates :notes, presence:false, length: { maximum: 50 }
end
