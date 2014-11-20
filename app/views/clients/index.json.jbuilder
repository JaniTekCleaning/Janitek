json.array!(@clients) do |client|
  json.extract! client, :id, :number, :email, :hot_button_list
  json.url client_url(client, format: :json)
end
