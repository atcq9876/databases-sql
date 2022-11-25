require 'recipe_repository'

def reset_recipes_table
  seed_sql = File.read('spec/seeds_recipes.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'recipes_directory_test' })
  connection.exec(seed_sql)
end

describe RecipeRepository do
  before(:each) do 
    reset_recipes_table
  end

  describe "#all" do
    it "returns a list of all recipes" do
      repo = RecipeRepository.new
      recipes = repo.all

      expect(recipes.length).to eq 3
      expect(recipes.first.id).to eq '1'
      expect(recipes.last.id).to eq '3'
      expect(recipes.last.recipe_name).to eq 'Mushroom Risotto'
    end
  end

  describe "#find()" do
    it "returns the first record when passed id of 1" do
      repo = RecipeRepository.new
      recipe = repo.find(1)

      expect(recipe.id).to eq '1'
      expect(recipe.recipe_name).to eq 'Margherita Pizza'
      expect(recipe.cooking_time).to eq '30'
      expect(recipe.rating).to eq '4'
    end

    it "returns the second record when passed id of 2" do
    repo = RecipeRepository.new
    recipe = repo.find(2)

    expect(recipe.id).to eq '2'
    expect(recipe.recipe_name).to eq 'Spaghetti Bolognese'
    expect(recipe.cooking_time).to eq '20'
    expect(recipe.rating).to eq '3'
    end
  end
end