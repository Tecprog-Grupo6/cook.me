class ChatRoomController < ApplicationController

  def show
    other_user = User.find_by(:username => params[:username])

    begin
      @chat = find_chat(other_user)
    rescue
      current_user.start_chat(other_user)
      @chat = find_chat(other_user)
    end

    result = render template: "chat_room/index.html.erb"
    return result
  end

  def create
    other_user = User.find_by(:username => params[:username])
    @chat = find_chat(other_user)

    @chat.messages.create(:body => params[:messages][:message_body],
                          :user_id => current_user.id)

    result = render template: "chat_room/index.html.erb"
    return result
  end

  def destroy
    other_user = User.find_by(:username => params[:username])
    @chat = find_chat(other_user)
    @chat.destroy

    result = redirect_to "/user/#{other_user.username}/chat"
    return result
  end

  def refresh
    result = redirect_to "/user/#{params[:username]}/chat"
    return result
  end

  private

  def find_chat(other_user)

    if current_user.has_chat?(other_user)
      if current_user.started_chat?(other_user)
        chat = ChatRoom.find_by(:user_one_id => current_user.id, :user_two_id => other_user.id)
      else
        chat = ChatRoom.find_by(:user_two_id => current_user.id, :user_one_id => other_user.id)
      end
    else
      raise "Chat not found"
    end

    return chat
  end

end
