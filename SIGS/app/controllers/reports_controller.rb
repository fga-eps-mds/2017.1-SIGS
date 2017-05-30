# frozen_string_literal: true

# Classe responsavel por gerar relatorio
class ReportsController < ApplicationController
  def by_room
    @departments = Department.all
    @rooms = Room.where(department: @departments[0])
    @weeks = obtain_weeks_of_period
  end

  def generate_by_room; end

  private

  def obtain_weeks_of_period
    weeks = []
    date = Period.find(1).initial_date.at_beginning_of_week
    last = Period.find(3).final_date.at_end_of_week
    while date <= last
      weeks.push date.strftime('%d/%m/%Y') + ' à ' + (date + 5.days)
                                                     .strftime('%d/%m/%Y')
      date += 7.days
      puts date.to_s
    end
    weeks
  end
end
