class CreateCoursesSchoolRoomsJoinTable < ActiveRecord::Migration[5.0]
  def change
    create_table :courses_school_rooms, id: false do |table|
      table.references :course, foreign_key: true
      table.references :school_room, foreign_key: true
    end
  end
end
