# frozen_string_literal: true

Hanami::Model.migration do
  change do
    alter_table :companies do
      add_column :interview_rating_total, Float, null: false, default: 0.0
      add_column :interviews, 'jsonb', default: '{}', null: false
    end
  end
end
