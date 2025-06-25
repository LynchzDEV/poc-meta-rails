class CoursesController < ApplicationController
  before_action :set_course, only: [:show]

  def index
    @courses = Course.all.order(:date)

    set_meta_tags(
      title: 'All Courses | Course Platform',
      description: 'Browse our complete catalog of professional courses. Learn new skills with expert instructors.',
      keywords: 'courses, education, professional development, learning',
      og: {
        title: 'All Courses | Course Platform',
        description: 'Browse our complete catalog of professional courses. Learn new skills with expert instructors.',
        type: 'website',
        url: courses_url,
        image: default_og_image
      },
      twitter: {
        card: 'summary_large_image',
        title: 'All Courses | Course Platform',
        description: 'Browse our complete catalog of professional courses.',
        image: default_og_image
      }
    )
  end

  def show
    og_image_url = course_og_image(@course)

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
        image: og_image_url,
        'image:width' => '1200',
        'image:height' => '630',
        'image:alt' => "#{@course.title} course at #{@course.school}"
      },
      twitter: {
        card: 'summary_large_image',
        title: @course.meta_title,
        description: @course.meta_description,
        image: og_image_url,
        'image:alt' => "#{@course.title} course at #{@course.school}"
      }
    )
  end

  private

  def set_course
    @course = Course.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to courses_path, alert: 'Course not found'
  end
end
