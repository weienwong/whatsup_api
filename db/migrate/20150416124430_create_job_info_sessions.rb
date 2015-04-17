class CreateJobInfoSessions < ActiveRecord::Migration
  def change
    create_table :job_info_sessions do |t|
      t.string :employer
      t.datetime :start_time
      t.datetime :end_time
      t.string :website
      t.text :target_audience
      t.text :description

      t.timestamps
    end
  end
end
