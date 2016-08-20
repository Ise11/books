json.array!(@books) do |book|
  json.extract! book, :id, :author, :name, :description, :owner_id, :rent_by_id
  json.url book_url(book, format: :json)
end
