class Search < ActiveRecord::Base

	def search_books
		books = Book.all

		books = books.where(["name LIKE ?","%#{keywords}%"]) if keywords.present?
		books = books.where(["category LIKE ?", category]) if category.present?
		books = books.where(["author LIKE ?","%#{author}%"]) if author.present?

		return books
	end


end
