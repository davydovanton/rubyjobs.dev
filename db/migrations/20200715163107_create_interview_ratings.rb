# frozen_string_literal: true

Hanami::Model.migration do
  change do
    create_table :interview_ratings do
      primary_key :id
      foreign_key :author_id, :accounts, on_delete: :cascade, null: false
      foreign_key :interview_id, :interviews, on_delete: :cascade, null: false

      column :overall_impression, Float, null: false, default: 3.0
      column :recommendation,     Float, null: false, default: 3.0
      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
