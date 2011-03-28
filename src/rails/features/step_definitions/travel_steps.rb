Given /^the following airports:$/ do |airports|
  airports.hashes.each do |airport|
    Airport.make!(airport[:code].to_sym)
  end
end

Given /^the following currencies:$/ do |currencies|
  currencies.hashes.each do |currency|
    Currency.make!(currency[:code].to_sym)
  end
end
