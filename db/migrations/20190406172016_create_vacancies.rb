# frozen_string_literal: true

Hanami::Model.migration do
  change do
    extension :pg_enum

    create_enum(:vacancy_position_types, %w[full_time part_time contractor intern temp other])
    create_enum(:vacancy_salary_currency_types, %w[rub usd eur])

    create_table :vacancies do
      primary_key :id
      foreign_key :contact_id, :contacts, on_delete: :cascade, null: false

      column :position, String, null: false
      column :position_type, 'vacancy_position_types', null: false, default: 'full_time'

      column :details_raw, String, null: false, text: true
      column :details,     String, null: false, text: true

      column :location, String
      column :remote_available, TrueClass, default: false

      column :published, TrueClass, default: false
      column :archived, TrueClass, default: false

      column :salary_min, Integer, null: false
      column :salary_max, Integer, null: false
      column :salary_currency, 'vacancy_salary_currency_types', null: false, default: 'rub'
      column :salary_unit, String, null: false

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
      column :deleted_at, DateTime
      column :archived_at, DateTime
    end
  end
end
