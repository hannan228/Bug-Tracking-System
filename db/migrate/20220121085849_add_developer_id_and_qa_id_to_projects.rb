class AddDeveloperIdAndQaIdToProjects < ActiveRecord::Migration[7.0]
  def change
    add_column :projects, :developer_id, :integer
    add_column :projects, :qa_id, :integer
  end
end
