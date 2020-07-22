# frozen_string_literal: true

Hanami::Model.migration do
  change do
    alter_table :interviews do
      add_foreign_key :company_id, :companies, on_delete: :cascade, null: false
    end
  end
end
