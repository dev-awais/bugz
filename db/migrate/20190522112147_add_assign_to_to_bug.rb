class AddAssignToToBug < ActiveRecord::Migration[5.2]
  def change
    add_column :bugs, :assign_to, :integer
  end
end
