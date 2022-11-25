require_relative 'recipe'

class RecipeRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query below:
    sql = "SELECT id, recipe_name, cooking_time, rating FROM recipes;"
    result_set = DatabaseConnection.exec_params(sql, [])

    recipes = []

    # loop through results and create an array of Recipe objects
    result_set.each do |record|
      recipe = Recipe.new
      recipe.id = record["id"]
      recipe.recipe_name = record["recipe_name"]
      recipe.cooking_time = record["cooking_time"]
      recipe.rating = record["rating"]
    
      recipes << recipe
    end

    # Return array of Recipe objects
    return recipes
  end

  # Finding one record
  # Taking the record id as an argument
  def find(id)
    sql = "SELECT id, recipe_name, cooking_time, rating FROM recipes WHERE id = $1;"

    params = [id]

    result_set = DatabaseConnection.exec_params(sql, params)
    record = result_set[0]

    # Convert the result to a Recipe object and return it
    recipe = Recipe.new
    recipe.id = record["id"]
    recipe.recipe_name = record["recipe_name"]
    recipe.cooking_time = record["cooking_time"]
    recipe.rating = record["rating"]

    return recipe
  end
end