class RemoveTargetAudience < ActiveRecord::Migration
  def change
    remove_column :job_info_sessions, :target_audience, :string
  end
end
