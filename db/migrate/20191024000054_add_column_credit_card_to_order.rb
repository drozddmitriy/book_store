class AddColumnCreditCardToOrder < ActiveRecord::Migration[5.2]
  def change
    add_reference :orders, :credit_card, foreign_key: true
  end
end
