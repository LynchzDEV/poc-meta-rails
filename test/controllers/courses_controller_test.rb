require "test_helper"

class CoursesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @course = Course.create!(
      title: "Test Course",
      total_hours: 10,
      price: 99.99,
      school: "Test School",
      date: Date.current + 1.week,
      time_period: "morning",
      description: "A test course for our test suite"
    )
  end

  test "should get index with proper meta tags" do
    get courses_url
    assert_response :success

    # Check that meta tags are present
    assert_select 'meta[property="og:title"]'
    assert_select 'meta[property="og:description"]'
    assert_select 'meta[property="og:image"]'
    assert_select 'meta[name="twitter:card"]'
  end

  test "should show course with proper meta tags" do
    get course_url(@course)
    assert_response :success

    # Check that course-specific meta tags are present
    assert_select 'meta[property="og:title"]' do |elements|
      assert elements.first['content'].include?(@course.title)
    end

    assert_select 'meta[property="og:description"]' do |elements|
      assert elements.first['content'].include?(@course.description.truncate(100))
    end

    assert_select 'meta[property="og:image"]'
    assert_select 'meta[property="og:image:width"][content="1200"]'
    assert_select 'meta[property="og:image:height"][content="630"]'

    # Check Twitter meta tags
    assert_select 'meta[name="twitter:card"][content="summary_large_image"]'
    assert_select 'meta[name="twitter:title"]'
    assert_select 'meta[name="twitter:description"]'
    assert_select 'meta[name="twitter:image"]'
  end

  test "course meta methods return proper lengths" do
    # Test that meta title is within limits
    assert @course.meta_title.length <= 60

    # Test that meta description is within limits
    assert @course.meta_description.length <= 160

    # Test that meta keywords are present
    assert_not_nil @course.meta_keywords
    assert @course.meta_keywords.include?(@course.school)
    assert @course.meta_keywords.include?(@course.title)
  end

  test "course meta methods handle long content properly" do
    # Create a course with very long title and description
    long_course = Course.create!(
      title: "This is a very long course title that exceeds the normal length limits",
      total_hours: 40,
      price: 199.99,
      school: "Very Long School Name That Should Be Truncated",
      date: Date.current + 2.weeks,
      time_period: "evening",
      description: "This is a very long description that should be truncated to fit within the meta description limits for social media platforms and search engines. It contains a lot of detailed information about the course content, objectives, and outcomes."
    )

    # Test that truncation works properly
    assert long_course.meta_title.length <= 60
    assert long_course.meta_description.length <= 160

    # Test that content is still meaningful after truncation
    assert long_course.meta_title.include?("This is a very long course")
    assert long_course.meta_description.include?("This is a very long description")
  end
end
