class FollowRequestsController < ApplicationController
  
  def notifications

      the_id = @current_user.id

      matching_follow_requests = FollowRequest.where({ :recipient_id => the_id })

      @the_follow_request = matching_follow_requests

      @list_of_answers = Answer.where({ :owner_id => the_id})

      



      
    render({ :template => "follow_requests/notify.html.erb" })

  end


  def view
      the_id = params.fetch("path_id")

      matching_follow_requests = FollowRequest.where({ :sender_id => the_id })

      if matching_follow_requests.count == 0
        redirect_to("/user/#{the_id}", { :notice => "this user is following no one"} )
      else
        @the_follow_request = matching_follow_requests

      render({ :template => "follow_requests/show.html.erb" })
    end
  end

  def viewing
    the_id = params.fetch("path_id")

    matching_follow_requests = FollowRequest.where({ :recipient_id => the_id })

    if matching_follow_requests.count == 0
      redirect_to("/user/#{the_id}", { :notice => "this user has no followers, help them out by following them!"} )
    else
      @the_follow_request = matching_follow_requests

      render({ :template => "follow_requests/showtwo.html.erb" })
    end
  end



  def add_follow
    following = params.fetch("following")
    follower = params.fetch("follower")

    @correct_user = User.where({ :id => following }).at(0)

    @matching_answers = Answer.where({ :owner => following })

    the_follow_request = FollowRequest.new
    the_follow_request.sender_id = params.fetch("follower")
    the_follow_request.recipient_id = params.fetch("following")
    the_follow_request.save

    redirect_to("/user/#{following}", { :notice => "you are now following this user"} )


  end

  def unfollow
    following = params.fetch("following")
    follower = params.fetch("follower")

    to_terminate = FollowRequest.where({:sender_id => follower, :recipient_id => following}).at(0)

    to_terminate.destroy


    

    redirect_to("/user/#{following}", { :notice => "you have unfollowed this user"} )


  end
  
  
  
  def index
    matching_follow_requests = FollowRequest.all

    @list_of_follow_requests = matching_follow_requests.order({ :created_at => :desc })

    render({ :template => "follow_requests/index.html.erb" })
  end

  

  def create
    the_follow_request = FollowRequest.new
    the_follow_request.sender_id = params.fetch("query_sender_id")
    the_follow_request.recipient_id = params.fetch("query_recipient_id")

    if the_follow_request.valid?
      the_follow_request.save
      redirect_to("/follow_requests", { :notice => "Follow request created successfully." })
    else
      redirect_to("/follow_requests", { :notice => "Follow request failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_follow_request = FollowRequest.where({ :id => the_id }).at(0)

    the_follow_request.sender_id = params.fetch("query_sender_id")
    the_follow_request.recipient_id = params.fetch("query_recipient_id")

    if the_follow_request.valid?
      the_follow_request.save
      redirect_to("/follow_requests/#{the_follow_request.id}", { :notice => "Follow request updated successfully."} )
    else
      redirect_to("/follow_requests/#{the_follow_request.id}", { :alert => "Follow request failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_follow_request = FollowRequest.where({ :id => the_id }).at(0)

    the_follow_request.destroy

    redirect_to("/follow_requests", { :notice => "Follow request deleted successfully."} )
  end
end
