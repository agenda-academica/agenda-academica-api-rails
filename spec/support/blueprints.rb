require 'machinist/active_record'

User.blueprint do
  email { "#{sn}@trashmail.com" }
  uid { object.email }
  provider { "email" }
  password { "12345678" }
end
