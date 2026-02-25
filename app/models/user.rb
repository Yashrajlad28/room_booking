class User < ApplicationRecord
    has_many :bookings
    has_many :rooms, through: :bookings


    before_validation :remove_extra_spaces

    # handles names like "Dr. Jacynthe Schimmel" 
    # move regex to constants
    validates :name, presence: true, format: { with: /\A[A-Za-z\s.\-']+\z/ }
    validates :department, presence: true, format: { with: /\A[A-Za-z ]+\z/ }


    private 
    
    def remove_extra_spaces
        self.name = name.squish if name.present?
        self.department = department.squish if department.present?
    end

end
