class CreateEventHosts < ActiveRecord::Migration
  def change
    create_table :event_hosts do |t|
      t.string :host_name
      t.text :description
      t.string :website

      t.timestamps
    end
  end
end
