module StockInventory
  def self.decrement_sold(resource, qty)
    resource.decrement_quantity_sold(qty)
  end

  def self.increment_sold(resource, qty)
    resource.increment_quantity_sold(qty)
  end
end
