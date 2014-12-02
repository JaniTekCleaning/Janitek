Fabricator(:user) do
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

Fabricator(:staff, class_name: :staff, from: :user) do
  # email do 
  #   sequence(:email) do |i|
  #     "staff.john_doe#{i}@example.test"
  #   end
  # end
end
Fabricator(:member, class_name: :member,from: :user) do
  # email do 
  #   sequence(:email) do |i|
  #     "member.john_doe#{i}@example.test"
  #   end
  # end
end
