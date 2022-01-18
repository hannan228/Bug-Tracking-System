class CreateBugs < ActiveRecord::Migration[7.0]
  def change
    create_table :bugs do |t|

      t.timestamps
    end
  end
end
