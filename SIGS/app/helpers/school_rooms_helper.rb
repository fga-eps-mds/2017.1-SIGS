module SchoolRoomsHelper

  def courses_of_school_room(course_ids)
    courses_names = []
    if course_ids.kind_of?(Array)
      course_ids.each do |course_id|
        course = Course.find(course_id)
        courses_names << course.name  
      end
    else 
      course = Course.find(course_ids)
      courses_names << course.name  
    end
    return courses_names
  end

end
