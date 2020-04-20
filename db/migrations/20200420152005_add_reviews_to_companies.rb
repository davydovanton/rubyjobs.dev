Hanami::Model.migration do
  change do
    alter_table :reviews do
      add_foreign_key :company_id, :companies, on_delete: :cascade, null: false
    end
  end
end
