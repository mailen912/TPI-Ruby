class Professional < ApplicationRecord
    has_many :appointments, dependent: :restrict_with_error
    validates :name, presence: true, uniqueness: true

end
