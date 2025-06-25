Course.create!([
  {
    title: "Full Stack Web Development",
    total_hours: 120,
    price: 599.99,
    school: "Tech Academy",
    date: Date.current + 2.weeks,
    time_period: "evening",
    description: "Learn modern web development with React, Node.js, and PostgreSQL. Build real-world applications from scratch and deploy them to production. Perfect for beginners who want to become professional developers."
  },
  {
    title: "Digital Marketing Fundamentals",
    total_hours: 40,
    price: 299.99,
    school: "Marketing Institute",
    date: Date.current + 1.week,
    time_period: "morning",
    description: "Master the basics of digital marketing including SEO, social media marketing, email campaigns, and analytics. Learn to create effective marketing strategies that drive real business results."
  },
  {
    title: "Data Science with Python",
    total_hours: 80,
    price: 449.99,
    school: "Data University",
    date: Date.current + 3.weeks,
    time_period: "noon",
    description: "Dive deep into data science using Python, pandas, numpy, and machine learning libraries. Work with real datasets and learn to extract meaningful insights from complex data."
  }
])

puts "Created #{Course.count} courses!"
