class LineItemService
  MINUS = 'minus'.freeze
  PLUS = 'plus'.freeze

  class << self
    def change_quantity(line_item, params)
      case params
      when PLUS
        line_item.quantity += 1
      when MINUS
        line_item.quantity -= 1 if line_item.quantity > 1
      end
    end
  end
end
