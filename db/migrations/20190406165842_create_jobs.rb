Hanami::Model.migration do
  change do
    extension :pg_enum

    create_enum(:job_position_types, %w[full_time part_time contractor intern temp other])

    create_table :jobs do
      primary_key :id
      foreign_key :contact_id, :contacts, on_delete: :cascade, null: false

      column :position, String, null: false
      column :position_type, 'job_position_types', null: false, default: 'full_time'

      column :details_raw, String, null: false, text: true
      column :details,     String, null: false, text: true

      column :location, String
      column :remote_available, TrueClass, default: false

      column :archived, TrueClass, default: false

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
      column :archived_at, DateTime
    end
  end
end
