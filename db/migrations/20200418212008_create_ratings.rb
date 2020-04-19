# frozen_string_literal: true

Hanami::Model.migration do
  change do
    create_table :ratings do
      primary_key :id
      foreign_key :author_id, :accounts, on_delete: :cascade, null: false
      foreign_key :review_id, :reviews, on_delete: :cascade, null: false

      column :salary_value,        Float, null: false, default: 3.0
      column :office,              Float, null: false, default: 3.0
      column :working_time,        Float, null: false, default: 3.0
      column :managment_level,     Float, null: false, default: 3.0
      column :project_interest,    Float, null: false, default: 3.0
      column :atmosphere,          Float, null: false, default: 3.0
      column :personal_growth,     Float, null: false, default: 3.0
      column :modern_technologies, Float, null: false, default: 3.0

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
