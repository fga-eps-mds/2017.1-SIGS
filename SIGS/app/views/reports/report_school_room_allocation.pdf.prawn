prawn_document(page_layout: :portrait) do |pdf|
  pdf.polygon [0,250], [0,0], [150,100] 
  pdf.polygon [100,0], [150,100], [200,0]
  pdf.text "relatorio gerado para todas as turmas", font-size => "20"
  pdf.move_down 20
  pdf.table @allocation.collect{|allocation| [allocation.school_room.name,allocation.school_room.discipline.name, allocation.room.name]}
end
