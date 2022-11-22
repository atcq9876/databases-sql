require_relative 'lib/database_connection'
require_relative 'lib/book_repository'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('book_store')

book_repository = BookRepository.new

book_repository.all.each do |book|
  puts book.title
end


# sql = 'SELECT id, title, author_name FROM books;'
# result = DatabaseConnection.exec_params(sql, [])

# result.each do |record|
#   p record
# end