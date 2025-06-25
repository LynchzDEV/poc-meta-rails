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

  # Meta tag helper methods optimized for social media
  def meta_title
    # Keep under 60 characters for optimal social media display
    title_part = title.truncate(40, omission: '')
    school_part = school.truncate(15, omission: '')
    "#{title_part} - #{school_part}"
  end

  def meta_description
    # Optimize for social media (160 characters max)
    base_description = description.truncate(100, omission: '...')
    details = " | #{total_hours}h • #{formatted_price} • #{time_period.capitalize}"

    max_length = 160 - details.length
    if base_description.length > max_length
      base_description = description.truncate(max_length, omission: '...')
    end

    "#{base_description}#{details}"
  end

  def meta_keywords
    [school, title, 'course', 'education', time_period].join(', ')
  end
end
