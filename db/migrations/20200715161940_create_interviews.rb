# frozen_string_literal: true

Hanami::Model.migration do
  change do
    create_table :interviews do
      primary_key :id
      foreign_key :author_id, :accounts, on_delete: :cascade, null: false

      column :body_raw, String, null: false, text: true
      column :body,     String, null: false, text: true

      column :anonymous, TrueClass, default: false

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
