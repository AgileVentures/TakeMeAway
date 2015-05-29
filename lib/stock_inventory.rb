module StockInventory
  def self.decrement_inventory(resource, qty)
    resource.decrement_stock(qty)
  end

  def self.increment_inventory(resource, qty)
    resource.increment_stock(qty)
  end
end
