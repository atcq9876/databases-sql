require_relative 'lib/database_connection'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('recipes_directory')

# Perform a SQL query on the database and get the result set.
sql = "SELECT id, recipe_name, cooking_time, rating FROM recipes;"
result_set = DatabaseConnection.exec_params(sql, [])

result_set.each do |recipe|
  p recipe
end
