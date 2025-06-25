module ApplicationHelper
  def default_og_image
    # Always return absolute URL for social media platforms
    return asset_url('og-default.svg') if Rails.env.production?

    # For development, use request.base_url to ensure proper URL
    "#{request.base_url}/og-default.svg"
  end

  def course_og_image(course)
    # Generate course-specific OG image with multiple fallbacks
    begin
      # Try to generate a course-specific image
      image_url = generate_reliable_course_image(course)

      # Validate the URL format
      uri = URI.parse(image_url)
      return image_url if uri.absolute? && %w[http https].include?(uri.scheme)

      # If URL is invalid, use default
      default_og_image
    rescue StandardError => e
      Rails.logger.error "Failed to generate OG image for course #{course.id}: #{e.message}"
      default_og_image
    end
  end

  private

  def generate_reliable_course_image(course)
    # Use a service that's known to work well with social media platforms
    title = url_safe_text(course.title, 30)
    school = url_safe_text(course.school, 20)

    # Try multiple reliable services in order of preference
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
    # Use placeholder.com - very reliable service
    text = "#{title}%20%7C%20#{school}".gsub(/\s+/, '%20')
    "https://via.placeholder.com/1200x630/4f46e5/ffffff?text=#{text}"
  end

  def generate_shields_image(title, school)
    # Fallback to a different service
    text = "#{title}-#{school}".gsub(/\s+/, '%20')
    "https://img.shields.io/badge/Course-#{text}-4f46e5?style=for-the-badge&labelColor=7c3aed"
  end

  def url_safe_text(text, limit = 50)
    text.to_s
        .strip
        .gsub(/[^\w\s-]/, '')          # Keep only word characters, spaces, and hyphens
        .gsub(/\s+/, ' ')              # Normalize spaces
        .truncate(limit, omission: '') # Limit length
        .strip
        .gsub(/\s+/, '%20')            # URL encode spaces
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
