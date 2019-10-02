# frozen_string_literal: true

Hanami::Model.migration do
  up do
    extension :pg_enum

    alter_table(:vacancies) do
      set_column_type :salary_currency, String
      set_column_allow_null(:salary_currency)
      set_column_default :salary_currency, nil
    end

    drop_enum(:vacancy_salary_currency_types)
    create_enum(:vacancy_salary_currency_types, %w[rub usd eur kzt])

    alter_table(:vacancies) do
      set_column_type :salary_currency,
                      'vacancy_salary_currency_types',
                      using: 'salary_currency::vacancy_salary_currency_types'

      set_column_default :salary_currency, 'rub'
      set_column_not_null :salary_currency
    end
  end

  down do
    extension :pg_enum

    alter_table(:vacancies) do
      set_column_type :salary_currency, String
      set_column_allow_null(:salary_currency)
      set_column_default :salary_currency, nil
    end

    drop_enum(:vacancy_salary_currency_types)
    create_enum(:vacancy_salary_currency_types, %w[rub usd eur])

    alter_table(:vacancies) do
      set_column_type :salary_currency,
                      'vacancy_salary_currency_types',
                      using: 'salary_currency::vacancy_salary_currency_types'

      set_column_default :salary_currency, 'rub'
      set_column_not_null :salary_currency
    end
  end
end
