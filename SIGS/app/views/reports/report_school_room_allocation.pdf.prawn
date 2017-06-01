prawn_document do |pdf|
  pdf.text "Listando Allocations"
  pdf.move_down 20
  pdf.table @allocation.collect{|p| [p.school_room_id.name,p.school_room_id.discipline.name]}
end