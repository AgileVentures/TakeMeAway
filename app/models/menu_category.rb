class MenuCategory < ActiveRecord::Base
  has_and_belongs_to_many :menus
  has_and_belongs_to_many :menu_items, join_table: 'menu_categories_menu_items'
  self.table_name = 'menu_categories'
  # NOTE: needed to explcitly define join_table for above association due to
  # a bug (seemingly) in shoulda (rspec) matcher 'have_and_belong_to_many'
  # That caused Rspec to look for a join table called 'menu_categories_items'
  
  # Also, the Rails documentation states that when join_table is used in an
  # association, the 'table_name' declaration has to immediately follow
  # that association statement.
   
  validates_presence_of :name
end
