# typed: false
# frozen_string_literal: true

Hanami::Model.migration do
  change do
    alter_table :vacancies do
      add_column :tags, :jsonb, default: '[]'
    end
  end
end
