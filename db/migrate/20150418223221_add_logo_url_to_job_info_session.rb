class AddLogoUrlToJobInfoSession < ActiveRecord::Migration
  def change
    add_column :job_info_sessions, :logo_url, :string
  end
end
