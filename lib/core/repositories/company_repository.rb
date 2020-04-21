# frozen_string_literal: true

require 'hanami/utils/hash'

class CompanyRepository < Hanami::Repository
  associations do
    has_many :reviews
  end

  def all_with_reviews
    aggregate(:reviews).map_to(Company).to_a
  end

  def already_exist?(company)
    # TODO: check for not allowed names like 'nda' or ''
    downcase_name = company.name.downcase.tr(' ', '')
    root.where { string.lower(string.replace(name, ' ', '')).is(downcase_name) }.exist?
  end

  def update_statistic(id, ratings) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    transaction do |_t|
      company = find(id)

      new_ratings = {}
      company_ratings = Hanami::Utils::Hash.symbolize(company.ratings)

      ALLOWED_RATINGS.each do |rating|
        next unless ratings[rating].to_f.positive?

        new_ratings[rating] = if company_ratings[rating].to_f.zero?
                                ratings[rating].to_f
                              else
                                (company_ratings[rating].to_f + ratings[rating].to_f) / 2
                              end
      end

      total_rating = (new_ratings.values.sum / new_ratings.values.count).round(1)

      update(id, ratings: new_ratings, rating_total: total_rating)
    end
  end

  ALLOWED_RATINGS = %i[
    salary_value
    office
    working_time
    project_interest
    atmosphere
    personal_growth
    modern_technologies
    management_level
    team_level
  ].freeze
end
