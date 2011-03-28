require 'machinist/active_record'

# Add your blueprints here.
#
# e.g.
#   Post.blueprint do
#     title { "Post #{sn}" }
#     body  { "Lorem ipsum..." }
#   end


Airport.blueprint(:MEL) do
  code { "MEL" }
  name { "MELBOURNE INTL" }
  city { "MELBOURNE" }
  country { "AUSTRALIA" }
  latitude { "-37.673333" }
  longitude { "144.843333" }
end

Airport.blueprint(:LAX) do
  code { "LAX" }
  name { "LOS ANGELES INTL" }
  city { "LOS ANGELES" }
  country { "UNITED STATES" }
  latitude { "33.942536" }
  longitude { "-118.408075" }
end

Currency.blueprint(:AUD) do
  name { "Australian Dollar" }
  code { "AUD" }
  country { "AUSTRALIA" }
end

Currency.blueprint(:USD) do
  name { "US Dollar" }
  code { "USD" }
  country { "UNITED STATES" }
end
