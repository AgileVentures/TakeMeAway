class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.belongs_to :menu_item, index: true, foreign_key: true
      t.attachment :file

      t.timestamps null: false
    end
  end
end
