# frozen_string_literal: true

Hanami::Model.migration do
  change do
    alter_table(:vacancies) do
      add_index :archived_at
    end
  end
end
