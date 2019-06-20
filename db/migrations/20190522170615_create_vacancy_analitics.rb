# typed: false
# frozen_string_literal: true

Hanami::Model.migration do
  change do
    create_table :vacancy_analitics do
      primary_key :id
      foreign_key :vacancy_id, :vacancies, on_delete: :cascade, null: false

      column :view_count, Integer, default: 0, null: false

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
