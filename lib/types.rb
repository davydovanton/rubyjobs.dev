# frozen_string_literal: true

require 'dry-types'

# Module with all project types
#
# {http://dry-rb.org/gems/dry-types/ Dry-types documentation}
module Core
  module Types
    include Dry::Types.module

    # System types
    LoggerLevel = Symbol.constructor(proc { |value| value.to_s.downcase.to_sym })
                        .default(:info)
                        .enum(:trace, :unknown, :error, :fatal, :warn, :info, :debug)

    UUID = Strict::String.constrained(
      format: /\A(\h{32}|\h{8}-\h{4}-\h{4}-\h{4}-\h{12})\z/
    )

    # Vacancies
    VacancyPositionTypes = String.constructor(proc { |value| value.to_s.downcase })
                                 .default('full_time')
                                 .enum('full_time', 'part_time', 'contractor', 'intern', 'temp', 'other')

    VacancySalaryCurrencyTypes = String.constructor(proc { |value| value.to_s.downcase })
                                       .default('rub')
                                       .enum('rub', 'usd', 'eur')

    VacancySalaryUnitTypes = String.constructor(proc { |value| value.to_s.downcase })
                                   .default('monthly')
                                   .enum('monthly', 'yearly', 'by hour', 'per project')

  end
end
