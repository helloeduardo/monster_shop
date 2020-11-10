class Cart
  attr_reader :contents

  def initialize(contents)
    @contents = contents || {}
    @contents.default = 0
  end

  def add_item(item_id)
    @contents[item_id] += 1
  end

  def less_item(item_id)
    @contents[item_id] -= 1
  end

  def count
    @contents.values.sum
  end

  def items
    @contents.map do |item_id, _|
      Item.find(item_id)
    end
  end

  def subtotal
    total = 0.0
    @contents.each do |item_id, quantity|
      total += Item.find(item_id).price * quantity
    end
    total
  end

  def grand_total
    grand_total = 0.0
    @contents.each do |item_id, quantity|
      item = Item.find(item_id)
      if item.eligible_discount(quantity)
        grand_total += item.adjusted_price * quantity
      else
        grand_total += item.price * quantity
      end
    end
    grand_total
  end

  def count_of(item_id)
    @contents[item_id.to_s]
  end

  def subtotal_of(item_id)
    @contents[item_id.to_s] * Item.find(item_id).price
  end

  def discounted_subtotal_of(item)
    @contents[item.id.to_s] * item.adjusted_price
  end

  def limit_reached?(item_id)
    count_of(item_id) == Item.find(item_id).inventory
  end
end
