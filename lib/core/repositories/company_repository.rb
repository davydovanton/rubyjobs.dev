# frozen_string_literal: true

class CompanyRepository < Hanami::Repository
  associations do
    has_many :reviews
  end

  def already_exist?(company)
    downcase_name = company.name.downcase.tr(' ', '')
    root.where { string.lower(string.replace(name, ' ', '')).is(downcase_name) }.exist?
  end
end
