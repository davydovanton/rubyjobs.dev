# typed: false
# frozen_string_literal: true

Hanami::Model.migration do
  change do
    create_table :contacts do
      primary_key :id

      column :email, String, null: false
      column :full_name, String, null: false
      column :company, String
      column :site, String

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
