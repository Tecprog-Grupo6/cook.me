require 'test_helper'

class ChatRoomControllerTest < ActionDispatch::IntegrationTest

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

    @message_1 = {
      :message_body => "Message test (1)"
    }
  end

  def teardown
    Message.destroy_all
    ChatRoom.destroy_all
    User.destroy_all
  end

  test "chat page should responds with active user" do
    post "/perfil/criar", :params => { :user =>  @user_1 }
    get "/logout"

    post "/perfil/criar", :params => { :user =>  @user_2 }
    get "/user/#{@user_1[:username]}/chat"

    assert_response(:success, "Chat page is not responding")
    assert_not_nil(ChatRoom.find_by(:user_one_id => User.find_by(:username => @user_2[:username]).id, :user_two_id => User.find_by(:username => @user_1[:username]).id), "ChatRoom wasn't found")
    assert_select("h2", "Chat com " + @user_1[:first_name] + " " + @user_1[:last_name], "Chat page text wasn't shown")
  end

  test "chat page should responds with passive user" do
    post "/perfil/criar", :params => { :user =>  @user_1 }
    get "/logout"

    post "/perfil/criar", :params => { :user =>  @user_2 }
    get "/user/#{@user_1[:username]}/chat"
    get "/logout"

    post "/login", :params => { :user => @user_1}
    get "/user/#{@user_2[:username]}/chat"

    assert_response(:success, "Chat page is not responding")
    assert_not_nil(ChatRoom.find_by(:user_one_id => User.find_by(:username => @user_2[:username]).id, :user_two_id => User.find_by(:username => @user_1[:username]).id), "ChatRoom wasn't found")
    assert_select("h2", "Chat com " + @user_2[:first_name] + " " + @user_2[:last_name], "Chat page text wasn't shown")
  end

  test "should create a message" do
    post "/perfil/criar", :params => { :user =>  @user_1 }
    get "/logout"

    post "/perfil/criar", :params => { :user =>  @user_2 }
    get "/user/#{@user_1[:username]}/chat"
    post "/user/#{@user_1[:username]}/chat", :params => { :messages => @message_1 }

    assert(Message.all.count > 0, "Message wasn't created")
    assert_equal(Message.first.user_id, User.find_by(:username => @user_2[:username]).id, "Message user_id is wrong")
  end

  test "should destroy a message" do
    post "/perfil/criar", :params => { :user =>  @user_1 }
    get "/logout"

    post "/perfil/criar", :params => { :user =>  @user_2 }
    get "/user/#{@user_1[:username]}/chat"
    post "/user/#{@user_1[:username]}/chat", :params => { :messages => @message_1 }

    assert(Message.all.count > 0, "Message wasn't created")

    post "/user/#{@user_1[:username]}/chat/destroy"

    assert_equal(Message.all.count, 0, "Message wasn't destroyed")
  end

  test "should refresh the chat page" do
    post "/perfil/criar", :params => { :user =>  @user_1 }
    get "/logout"

    post "/perfil/criar", :params => { :user =>  @user_2 }
    get "/user/#{@user_1[:username]}/chat"

    assert_response(:success, "Chat page is not responding")
    assert_select("h2", "Chat com " + @user_1[:first_name] + " " + @user_1[:last_name], "Chat page text wasn't shown")

    post "/user/#{@user_1[:username]}/chat/refresh"

    assert_response(:redirect, "Chat page is not refreshing")
  end

end
