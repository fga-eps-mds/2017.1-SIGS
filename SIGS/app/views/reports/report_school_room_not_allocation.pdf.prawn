prawn_document(page_layout: :portrait) do |pdf| 
  
  pdf.text "SIGS - Sistema Gerenciamento Salas", :size => 10, :color=>"bbbbbb", :align=>:center

  df.move_down 10

  pdf.text @sem_school_room_not_allocation

  pdf.formatted_text [{:text =>"Relatorio gerado para todas as turmas não alocadas" ,:styles =>[:bold], :size => 20, :color=>"333333"}]
  pdf.move_down 20		
  
  data = [["Turma", "Disciplina", "Estatus alocação", "Sala"]]	 
  data += @school_room.collect{|school_room| [school_room.name, school_room.discipline.name, "Não Alocada", "---"]}
  pdf.table(data, :header => true, :column_widths => [130, 130, 130, 130])

end