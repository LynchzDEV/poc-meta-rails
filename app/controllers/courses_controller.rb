class CoursesController < ApplicationController
  before_action :set_course, only: [:show]

  def index
    @courses = Course.all.order(:date)

    set_meta_tags(
      title: 'All Courses',
      description: 'Browse our complete catalog of professional courses'
    )
  end

  def show
    set_meta_tags(
      title: @course.meta_title,
      description: @course.meta_description,
      keywords: "#{@course.school}, #{@course.title}, course, education",
      og: {
        title: @course.meta_title,
        description: @course.meta_description,
        type: 'article',
        url: course_url(@course),
        image: course_og_image(@course)
      },
      twitter: {
        card: 'summary_large_image',
        title: @course.meta_title,
        description: @course.meta_description,
        image: course_og_image(@course)
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
