class CreateProjectsUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :projects_users do |t|
      t.integer :user_id
      t.integer :project_id

      t.timestamps
    end
  end
end
