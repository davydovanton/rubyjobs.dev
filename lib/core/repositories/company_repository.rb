# frozen_string_literal: true

class CompanyRepository < Hanami::Repository
  associations do
    has_many :reviews
  end

  def already_exist?(company)
    downcase_name = company.name.downcase
    root.where { string.lower(name).is(downcase_name) }.exist?
  end
end
