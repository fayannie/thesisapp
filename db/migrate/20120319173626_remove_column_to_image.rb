class RemoveColumnToImage < ActiveRecord::Migration
  def up
    remove_column :images, :image_file
      end

  def down
    add_column :images, :image_file, :string
  end
end
