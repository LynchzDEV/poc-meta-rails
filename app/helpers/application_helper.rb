module ApplicationHelper
  def default_og_image
    "https://via.placeholder.com/1200x630/4f46e5/ffffff?text=Course+Platform"
  end

  def course_og_image(course)
    "https://via.placeholder.com/1200x630/4f46e5/ffffff?text=#{CGI.escape(course.title)}"
  end

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
