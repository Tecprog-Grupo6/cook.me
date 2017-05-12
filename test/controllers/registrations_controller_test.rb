require 'test_helper'

class RegistrationsControllerTest < ActionDispatch::IntegrationTest

  def setup
    User.destroy_all

    @user_1 =  {
        :first_name => "John",
        :last_name => "Doe",
        :username => "johndoe",
        :email => "johndoe@email.com",
        :password => "123456",
        :password_confirmation => "123456"
    }
    @user_2 =  {
        :first_name => "John",
        :last_name => "Doe",
        :username => "johndoe"
    }
    @user_edit_1 =  {
        :first_name => "John",
        :last_name => "Doe",
        :username => "johndoe",
        :email => "johndoe@otheremail.com",
        :password => "",
        :password_confirmation => "",
        :current_password => "123456",
        :avatar => nil
    }
    @user_edit_2 =  {
        :first_name => "John",
        :last_name => "Doe",
        :username => "johndoe",
        :email => "johndoe@otheremail.com",
        :password => "",
        :password_confirmation => "",
        :current_password => "654321",
        :avatar => nil
    }
    @user_edit_3 =  {
        :first_name => "John",
        :last_name => "Doe",
        :username => "johndoe",
        :email => "johndoe@email.com",
        :password => "654321",
        :password_confirmation => "654321",
        :current_password => "123456",
        :avatar => nil
    }
    @user_edit_4 =  {
        :first_name => "",
        :last_name => "Doe",
        :username => "johndoe",
        :email => "johndoe@email.com",
        :password => "",
        :password_confirmation => "",
        :current_password => "123456",
        :avatar => nil
    }
    @user_edit_5 =  {
        :first_name => "John",
        :last_name => "Doe",
        :username => "johndoe",
        :email => "johndoe@email.com",
        :password => "",
        :password_confirmation => "",
        :current_password => "123456",
        :avatar => ""
    }
  end

  def teardown
    User.destroy_all
  end

  test "should responds" do
    get "/perfil/criar"
    assert_response(:success, "No response")
  end

  test "should create a user" do
    post "/perfil/criar", :params => { :user =>  @user_1 }
    assert_not_nil(User.find_by(:username => @user_1[:username]), "User wasn't created")
    User.find_by(:username => @user_1[:username]).destroy
  end

  test "shouldn't create a user" do
    post "/perfil/criar", :params => { :user =>  @user_2 }
    assert_nil(User.find_by(:username => @user_2[:username]), "User was created")
  end

  test "should update a user" do
    post "/perfil/criar", :params => { :user =>  @user_1 }
    assert_not_nil(User.find_by(:username => @user_1[:username]), "User wasn't created")
    assert_equal(User.find_by(:username => @user_1[:username])[:email], @user_1[:email], "E-mail isn't correct")

    post "/login", :params => { :email => @user_1[:email], :password => @user_1[:password] }

    post "/perfil/atualizar", :params => { :user =>  @user_edit_1 }
    assert_equal(User.find_by(:username => @user_1[:username])[:email], @user_edit_1[:email], "E-mail wasn't changed")

    User.find_by(:username => @user_1[:username]).destroy
  end

  test "shouldn't update a user (wrong password)" do
    post "/perfil/criar", :params => { :user =>  @user_1 }
    assert_not_nil(User.find_by(:username => @user_1[:username]), "User wasn't created")
    assert_equal(User.find_by(:username => @user_1[:username])[:email], @user_1[:email], "E-mail isn't correct")

    post "/login", :params => { :email => @user_1[:email], :password => @user_1[:password] }

    post "/perfil/atualizar", :params => { :user =>  @user_edit_2 }
    assert_equal(User.find_by(:username => @user_1[:username])[:email], @user_1[:email], "E-mail was changed")

    User.find_by(:username => @user_1[:username]).destroy
  end

  test "should update a user changing password" do
    post "/perfil/criar", :params => { :user =>  @user_1 }
    assert_not_nil(User.find_by(:username => @user_1[:username]), "User wasn't created")

    post "/login", :params => { :email => @user_1[:email], :password => @user_1[:password] }
    post "/perfil/atualizar", :params => { :user =>  @user_edit_3 }
    get "/logout"
    post "/login", :params => { :email => @user_1[:email], :password => @user_edit_3[:password] }

    assert_response(:success, "Password wasn't changed")

    User.find_by(:username => @user_1[:username]).destroy
  end

  test "shouldn't update a user (blank field)" do
    post "/perfil/criar", :params => { :user =>  @user_1 }
    assert_not_nil(User.find_by(:username => @user_1[:username]), "User wasn't created")

    post "/login", :params => { :email => @user_1[:email], :password => @user_1[:password] }
    post "/perfil/atualizar", :params => { :user =>  @user_edit_4 }

    assert_equal(User.find_by(:username => @user_1[:username])[:first_name], @user_1[:first_name], "First name was changed")

    User.find_by(:username => @user_1[:username]).destroy
  end

  test "should update a user changing avatar" do
    post "/perfil/criar", :params => { :user =>  @user_1 }
    assert_not_nil(User.find_by(:username => @user_1[:username]), "User wasn't created")

    post "/login", :params => { :email => @user_1[:email], :password => @user_1[:password] }
    post "/perfil/atualizar", :params => { :user =>  @user_edit_5 }
    
    assert_response(:success, "Avatar wasn't changed")

    User.find_by(:username => @user_1[:username]).destroy
  end

end
