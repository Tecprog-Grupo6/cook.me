require 'test_helper'

class FeedControllerTest < ActionDispatch::IntegrationTest

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

    @user_2 = {
      :first_name => "Will",
      :last_name => "Smith",
      :username => "willsmith",
      :email => "willsmith@email.com",
      :password => "123456",
      :password_confirmation => "123456",
      :birthday => "01/01/1990",
      :gender => "Masculino"
    }

    @recipe_1 = {
      :title => "Best recipe",
      :served_people => "10",
      :prepare_time => "30",
      :text => "Prepare etc etc"
    }
  end

  def teardown
    User.destroy_all
  end

  test "should responds with recipes" do
    post "/perfil/criar", :params => { :user =>  @user_1 }
    post "/receita", :params => { :recipes => @recipe_1 }
    get "/logout"

    post "/perfil/criar", :params => { :user =>  @user_2 }
    post "/user/#{@user_1[:username]}/followed_by/#{@user_2[:username]}"
    get "/"

    assert_response(:success, "Feed page is not responding")
    assert_select("h3 a", User.find_by(:email => 'johndoe@email.com').recipes.find_by(:title => 'Best recipe').title, "Recipe wasn't shown on feed page")
  end

  test "should responds without recipes" do
    post "/perfil/criar", :params => { :user =>  @user_1 }
    get "/"

    assert_response(:success, "Feed page is not responding")
    assert_select("h4", "Os usuários que você segue ainda não possuem receitas!", "Feed page without recipes wasn't shown")
  end

end
