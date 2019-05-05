class Company < ApplicationRecord
  has_many :employees
  has_many :offices
  has_many :buildings, through: :offices

  validates :name, presence: true

  def total_rent
    self.offices.uniq.map { |office| office.building.rent_per_floor }.sum
  end
end
