class Course < ApplicationRecord
  # Validations ensure data integrity
  validates :title, presence: true, length: { minimum: 3, maximum: 100 }
  validates :total_hours, presence: true, numericality: { greater_than: 0 }
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :school, presence: true
  validates :date, presence: true
  validates :time_period, presence: true, inclusion: { in: %w[morning noon evening] }
  validates :description, presence: true, length: { minimum: 10 }

  # Scopes for filtering courses
  scope :by_time_period, ->(period) { where(time_period: period) }
  scope :by_school, ->(school) { where(school: school) }
  scope :upcoming, -> { where('date >= ?', Date.current) }

  # Helper method for displaying formatted price
  def formatted_price
    "$#{price.to_f}"
  end

  # Meta tag helper methods
  def meta_title
    "#{title} - #{school}"
  end

  def meta_description
    "#{description.truncate(160)} | Duration: #{total_hours} hours | Price: #{formatted_price}"
  end

  # Remove the problematic meta_image_url method - we'll handle this in controllers/helpers
end
