class Currency < ActiveRecord::Base
  def convert_to currency
    n = 1.to_money(self.code.to_sym)
    n.exchange_to(currency.code.to_sym)
  end
end
