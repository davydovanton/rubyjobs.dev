# typed: ignore
# frozen_string_literal: true

Container.boot(:persistance) do |_container|
  init do
    VacancyRepository.enable_pagination!
  end
end
