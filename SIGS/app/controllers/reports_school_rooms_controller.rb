# frozen_string_literal: true

# Classe responsavel por gerar relatorio por turma
class ReportsSchoolRoomsController < ApplicationController
  def school_reports; end

  def report_school_room_not_allocated
    @allocation = Allocation.all
    id_school_room = []
    cont_id = 0
    @allocation.each do |allocation|
      id_school_room[cont_id] = allocation.school_room_id
      cont_id += 1
    end
    @school_room = SchoolRoom.where('id NOT IN (?)', id_school_room)
    # if @school_room.nil?
    #   return @sem_school_room_not_allocation = 'Nao foram encontradas
    #                                     turmas sem alocacao'
    # else
    #   return @school_room
  end

  def report_school_room_all
    report_school_room_not_allocated
  end

  def report_school_room_allocated
    @allocation = Allocation.all
    # if @allocation.nil?
    #   return @sem_allocation = 'Nao foram encontradas turmas alocadas'
    # else
    #   return @allocation
  end
end
