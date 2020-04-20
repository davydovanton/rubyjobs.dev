# frozen_string_literal: true

Hanami::Model.migration do
  change do
    alter_table :ratings do
      rename_column :managment_level, :management_level

      add_column :team_level, Float, null: false, default: 3.0
    end
  end
end
