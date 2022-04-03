class LikesController < ApplicationController

  before_action :find_post
  before_action :find_like, only: [:destroy]

  def create
    if already_liked?
      flash[:notice] = "You can't like more than once."
      redirect_to root_path
    else
      @postdata =  Message.all.find(params[:id])
      @datas = Like.create(user_id: current_user.id, message_id: @postdata.id)
      respond_to do |format|
        if @datas.save
            format.html { redirect_to root_path, notice: "Like successfully added..." }
          else
            puts  @datas.errors.full_messages
        end
      end
    end
	end 

  def find_like
  	@like = @post.likes.find_by(user_id: current_user.id)	
  end

	def destroy
	  if !(already_liked?)
	    flash[:notice] = "Cannot unlike"
	  else
	    @like.destroy
	  end
	    redirect_to root_path
	    flash[:notice] = "Successfully Unlike..."
  end 

	private  
    def find_post
      @post = Message.find(params[:id])
    end 
    def already_liked?
      Like.where(user_id: current_user.id, message_id: params[:id]).exists?
    end

end
