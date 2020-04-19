# frozen_string_literal: true

Hanami::Model.migration do
  change do
    create_table :accounts do
      primary_key :id

      column :github, String, null: false, unique: true
      column :email, String, null: false, unique: true
      column :name, String, null: false

      column :avatar_url, String, null: false

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
