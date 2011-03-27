class Airport < ActiveRecord::Base
  validates_presence_of :country

  def self.search q
    conditions = {}
    for term in q.split ' '
      if conditions == {}
        conditions = { :name.matches => "%#{term}%" } |
                      { :code.matches => "%#{term}%" } |
                      { :city.matches => "%#{term}%" } |
                      { :country.matches => "%#{term}%" }
        else
        conditions = conditions | { :name.matches => "%#{term}%" }
        conditions = conditions | { :code.matches => "%#{term}%" }
        conditions = conditions | { :city.matches => "%#{term}%" }
        conditions = conditions | { :country.matches => "%#{term}%" }
      end
    end
    where(conditions)
  end
  
  def currency
    Currency.where(:country => self.country).first
  end
  
end
