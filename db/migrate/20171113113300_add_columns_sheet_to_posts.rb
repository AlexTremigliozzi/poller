class AddColumnsSheetToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :reference, :string
    add_column :posts, :recipient, :string
    add_column :posts, :critical_issue, :text
    add_column :posts, :expected_result, :text
    add_column :posts, :monitoring, :string
    add_column :posts, :effectiveness, :string
  end
end
