class AddColumnToImage < ActiveRecord::Migration
  def change
    add_column :images, :image_file, :string

  end
end
