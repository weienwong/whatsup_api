class AddLocationToJobInfoSession < ActiveRecord::Migration
  def change
    add_column :job_info_sessions, :location, :string
  end
end
