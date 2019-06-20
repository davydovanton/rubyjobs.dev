# typed: false
# frozen_string_literal: true

class VacancyAnaliticRepository < Hanami::Repository
  associations do
    belongs_to :vacancy
  end

  def increase_view_count(vacancy_id)
    transaction do
      vacancy_analitics = root.where(vacancy_id: vacancy_id).one

      if vacancy_analitics
        update(vacancy_analitics.id, view_count: vacancy_analitics.view_count + 1)
      else
        create(vacancy_id: vacancy_id, view_count: 1)
      end
    end
  end
end
