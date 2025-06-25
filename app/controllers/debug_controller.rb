class DebugController < ApplicationController
  def meta_tags
    # Only allow in development environment
    unless Rails.env.development?
      redirect_to root_path and return
    end

    @course = Course.first

    if @course
      # Set the same meta tags as the course show action
      set_meta_tags(
        title: @course.meta_title,
        description: @course.meta_description,
        keywords: "#{@course.school}, #{@course.title}, course, education",
        canonical: course_url(@course),
        og: {
          title: @course.meta_title,
          description: @course.meta_description,
          type: 'article',
          url: course_url(@course),
          image: course_og_image(@course),
          'image:width' => '1200',
          'image:height' => '630',
          'image:alt' => "#{@course.title} course at #{@course.school}"
        }
      )
    end
  end
end
