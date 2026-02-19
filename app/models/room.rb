class Room < ApplicationRecord
    scope :available, -> { where(booked: false) }
    has_many :bookings
    has_many :users, through: :bookings

    before_validation :remove_extra_spaces

    validates :name, presence: true, format: { with: /\A[A-Za-z ]+\z/ }
    validates :booked, inclusion: { in: [true, false] }


    private 
    
    def remove_extra_spaces
        self.name = name.squish if name.present?
    end


end
