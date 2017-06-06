prawn_document(page_layout: :portrait) do |pdf|


  pdf.text "SIGS - Sistema Gerenciamento Salas", :size => 10, :color=>"bbbbbb", :align=>:center
   pdf.move_down 10

  pdf.text @sem_turmas

  pdf.formatted_text [{:text =>"Relatorio gerado para todas as turmas" ,:styles =>[:bold], :size => 20, :color=>"333333"}]
  pdf.move_down 20		
  
  data = [["Turma", "Disciplina", "Estatus alocação", "Sala"]]
 
  data += @allocation.collect{|allocation| [allocation.school_room.name,allocation.school_room.discipline.name, "Alocado", allocation.room.name]}

  data += @school_room.collect{|school_room| [school_room.name, school_room.discipline.name, "Não Alocada", "---"]}
  
  pdf.table(data, :header => true, :column_widths => [130, 130, 130, 130])
end