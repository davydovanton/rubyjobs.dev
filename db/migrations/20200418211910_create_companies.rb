Hanami::Model.migration do
  change do
    create_table :companies do
      primary_key :id

      column :name, String, null: false, unique: true
      column :url, String, null: false

      column :rating_total, Float, null: false, default: 0.0
      column :ratings, 'jsonb', default: '{}', null: false

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
