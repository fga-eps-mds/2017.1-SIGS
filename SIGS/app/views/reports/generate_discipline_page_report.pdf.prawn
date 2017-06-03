prawn_document do |pdf|
    pdf.text 'Current School Rooms are:'
    pdf.move_down 20
    pdf.table @allocations.collect{|p| [p.school_room.name]}
end
