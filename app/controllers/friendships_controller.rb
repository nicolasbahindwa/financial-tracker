class FriendshipsController < ApplicationController

    def index
        @my_friends = current_user.friends
    end

    def create

        friend = User.find(params[:friend])
        current_user.friendships.build(friend_id: friend.id)
        if current_user.save
            flash[:notice] = "You start following #{friend.full_name}"
        else
            flash[:alert] = "There was something wrong with the tracking request"
        end
        redirect_to my_friends_path

    end

    def destroy
        friendship = current_user.friendships.where(friend_id: params[:id]).first
        friendship.destroy
        flash[:notice] = "stopped following"
        redirect_to my_friends_path
    end

    def search
        # byebug
        if params[:friend].present?
            # @friend = params[:friend]
            @friends = Friendship.search(params[:friend])
            @friends = current_user.except_current_user(@friends)
            if  @friends
                respond_to do |format|
                    format.js { render partial:'friendships/result' }
                end
            else
                respond_to do |format|
                    flash.now[:error] = "Couldn't find user"
                    format.js { render partial: 'friendships/result' }
                end
            end
        else
            respond_to do |format|
                flash.now[:alert] = "Please enter a friend name or email to search"
                format.js { render partial: 'friendships/result'  }
            end
        end
        
    end



    
    
end