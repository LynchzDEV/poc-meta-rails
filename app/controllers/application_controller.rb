class ApplicationController < ActionController::Base
  include ApplicationHelper

  before_action :set_default_meta_tags

  private

  def set_default_meta_tags
    set_meta_tags(
      site: 'Course Platform',
      title: 'Learn New Skills Today',
      description: 'Find the perfect course to advance your career',
      keywords: 'courses, education, learning, skills',
      og: {
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: default_og_image
      },
      twitter: {
        card: 'summary_large_image',
        site: '@courseplatform',
        title: :title,
        description: :description,
        image: default_og_image
      }
    )
  end
end
