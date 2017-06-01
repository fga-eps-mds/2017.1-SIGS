class CreateCoursesSchoolRoomsJoinTable < ActiveRecord::Migration[5.0]
  def change
    create_join_table :courses, :school_rooms do |t|
     t.index [:course_id, :school_room_id]
     t.index [:school_room_id, :course_id]
    end
  end
end
