class ChangeReferenceToPost < ActiveRecord::Migration
  def change
    remove_reference :categories, :post, index: true

  end
end
