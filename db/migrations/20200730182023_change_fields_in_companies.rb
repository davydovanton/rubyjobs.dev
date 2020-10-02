Hanami::Model.migration do
  change do
    alter_table :companies do
      rename_column :interviews, :interview_ratings
    end
  end
end
