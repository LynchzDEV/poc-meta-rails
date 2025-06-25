module ApplicationHelper
  def default_og_image
    return asset_url('og-default.svg') if Rails.env.production?
    "#{request.base_url}/og-default.svg"
  end

  def course_og_image(course)
    begin
      image_url = generate_reliable_course_image(course)

      uri = URI.parse(image_url)
      return image_url if uri.absolute? && %w[http https].include?(uri.scheme)

      default_og_image
    rescue StandardError => e
      Rails.logger.error "Failed to generate OG image for course #{course.id}: #{e.message}"
      default_og_image
    end
  end

  private

  def generate_reliable_course_image(course)
    title = url_safe_text(course.title, 30)
    school = url_safe_text(course.school, 20)

    services = [
      lambda { generate_placeholder_image(title, school) },
      lambda { generate_shields_image(title, school) },
      lambda { default_og_image }
    ]

    services.each do |service|
      result = service.call
      return result if result
    end

    default_og_image
  end

  def generate_placeholder_image(title, school)
    text = "#{title}%20%7C%20#{school}".gsub(/\s+/, '%20')
    "https://via.placeholder.com/1200x630/4f46e5/ffffff?text=#{text}"
  end

  def generate_shields_image(title, school)
    text = "#{title}-#{school}".gsub(/\s+/, '%20')
    "https://img.shields.io/badge/Course-#{text}-4f46e5?style=for-the-badge&labelColor=7c3aed"
  end

  def url_safe_text(text, limit = 50)
    text.to_s
        .strip
        .gsub(/[^\w\s-]/, '')
        .gsub(/\s+/, ' ')
        .truncate(limit, omission: '')
        .strip
        .gsub(/\s+/, '%20')
  end

  public

  def format_time_period(period)
    case period
    when 'morning'
      '🌅 Morning (9AM - 12PM)'
    when 'noon'
      '☀️ Afternoon (1PM - 5PM)'
    when 'evening'
      '🌙 Evening (6PM - 9PM)'
    else
      period.capitalize
    end
  end

  def meta_title
    if content_for?(:title)
      content_for(:title) + " | Course Platform"
    else
      "Course Platform - Learn New Skills Today"
    end
  end

  def page_title(title)
    content_for(:title, title)
  end
end
