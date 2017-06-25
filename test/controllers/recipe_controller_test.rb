require 'test_helper'

class RecipeControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user_1 =  {
        :first_name => "John",
        :last_name => "Doe",
        :username => "johndoe",
        :email => "johndoe@email.com",
        :password => "123456",
        :password_confirmation => "123456",
        :birthday => "11/02/1993"
    }

    @recipe_1 = {
      :title => "Best recipe",
      :served_people => "10",
      :prepare_time => "30",
      :text => "Prepare etc etc"
    }

    @recipe_1_without_title = {
      :served_people => "10",
      :prepare_time => "30",
      :text => "Prepare etc etc"
    }

    @recipe_1_edited = {
      :title => "Best recipe edited",
      :served_people => "10",
      :prepare_time => "30",
      :text => "Prepare etc etc"
    }
  end

  def teardown
    Recipe.destroy_all
    User.destroy_all
  end

  test "recipe create page should responds" do
    post "/perfil/criar", :params => { :user =>  @user_1 }

    get "/receita/criar"
    assert_response(:success, "Recipe create page doesn't respond")
  end

  test "recipe not found page should responds" do
    nil_recipe_id = 123456
    begin
      nil_recipe = Recipe.find(nil_recipe_id)
    rescue
      nil_recipe = nil
    end

    assert_nil(nil_recipe, "Recipe isn't nil")

    get "/receita/visualizar/#{nil_recipe_id}"

    assert_response(:success, "Recipe create page doesn't respond")
    assert_select("p", "Esta receita não existe!", "Recipe not found text wasn't shown")
  end

  test "recipe edit page should responds" do
    post "/perfil/criar", :params => { :user =>  @user_1 }
    post "/receita", :params => { :recipes => @recipe_1 }

    get "/receita/editar/#{Recipe.find_by(:title => @recipe_1[:title]).id}"
    assert_response(:success, "Recipe edit page doesn't respond")
    assert_select("h1 span", Recipe.find_by(:title => @recipe_1[:title]).title, "Recipe edit page doesn't shown current recipe title")
  end

  test "should create a recipe" do
    post "/perfil/criar", :params => { :user =>  @user_1 }
    post "/receita", :params => { :recipes => @recipe_1 }

    assert_not_nil(User.find_by(:email => 'johndoe@email.com').recipes.find_by(:title => 'Best recipe'), "Recipe wasn't created")
  end

  test "shouldn't create a recipe" do
    post "/perfil/criar", :params => { :user =>  @user_1 }
    post "/receita", :params => { :recipes => @recipe_1_without_title }

    assert_nil(User.find_by(:email => 'johndoe@email.com').recipes.find_by(:title => 'Best recipe'), "Recipe was created")
  end

  test "should show a recipe as owner" do
    post "/perfil/criar", :params => { :user =>  @user_1 }
    post "/receita", :params => { :recipes => @recipe_1 }
    get "/receita/visualizar/#{User.find_by(:email => 'johndoe@email.com').recipes.find_by(:title => 'Best recipe').id}"

    assert_select 'form input' do |btn|
      assert(btn.count > 0)
    end

    #assert_select "form", "Deletar receita", "This page must contain a input that say 'Deletar receita' "
    assert_select("h3", User.find_by(:email => 'johndoe@email.com').recipes.find_by(:title => 'Best recipe').title, "Recipe wasn't shown")
  end


  test "should show a recipe not as owner" do
    post "/perfil/criar", :params => { :user =>  @user_1 }
    post "/receita", :params => { :recipes => @recipe_1 }
    get "/logout"
    get "/receita/visualizar/#{User.find_by(:email => 'johndoe@email.com').recipes.find_by(:title => 'Best recipe').id}"

    assert_select "form", {count: 0, text: "Deletar receita"}, "This page must contain no inputs that say 'Deletar receita' "
    assert_select("h3", User.find_by(:email => 'johndoe@email.com').recipes.find_by(:title => 'Best recipe').title, "Recipe wasn't shown")
  end

  test "should edit a recipe" do
    post "/perfil/criar", :params => { :user =>  @user_1 }
    post "/receita", :params => { :recipes => @recipe_1 }

    @old_recipe = User.find_by(:email => 'johndoe@email.com').recipes.find_by(:title => 'Best recipe')
    post "/receita/#{User.find_by(:email => 'johndoe@email.com').recipes.find_by(:title => 'Best recipe').id}", :params => { :recipes => @recipe_1_edited }
    @new_recipe = Recipe.find(@old_recipe.id)

    assert_not_equal(@old_recipe.title, @new_recipe.title, "Recipe wasn't edited")
  end

end
