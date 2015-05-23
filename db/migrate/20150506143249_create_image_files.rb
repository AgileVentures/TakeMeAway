class CreateImageFiles < ActiveRecord::Migration
  def self.up
    create_table :files do |t|
      t.integer    :image_id
      t.string     :style
      t.binary     :file_contents

      t.timestamps null: false
    end
  end

  def self.down
    drop_table :files
  end
end
