Fabricator(:member) do
  password 'password'
  password_confirmation 'password'
  email do 
    sequence(:email) do |i|
      "john_doe#{i}@example.test"
    end
  end
  first_name do 
    sequence(:first_name) do |i|
      "John #{i}"
    end
  end
  last_name 'Doe'
end
