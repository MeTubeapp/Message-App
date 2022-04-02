class MessagesController < ApplicationController
  before_action :set_message, only: %i[ show edit update destroy ]
  

  # GET /messages or /messages.json
  def index
    @messages = Message.all
      if unless current_user['name'].to_s.strip.empty?
        @div_class = :"text-center"
        @div_content = "Login as "+current_user['name']
      else
        @div_class = :"text-center"
        @div_content = 'Username Unknown'
      end
    end
  end

  # GET /messages/1 or /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages or /messages.json
  def create
    @message = current_user.messages.build(message_params)
    respond_to do |format|
      if @message.save
        format.html { redirect_to message_url(@message), notice: "Message was successfully created." }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1 or /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to message_url(@message), notice: "Message was successfully updated." }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1 or /messages/1.json
  def destroy
    @message.destroy

    respond_to do |format|
      format.html { redirect_to messages_url, notice: "Message was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def like
    #grabb info the post 
    @post =  Message.all.find(params[:id])
    @datas = Like.create(user_id: current_user.id, message_id: @post.id)
    respond_to do |format|
      if @datas.save
          format.html { redirect_to root_path, notice: "Like successfully added." }
        else
          puts  @datas.errors.full_messages
      end
    end
  end

  def unlike
    #grabb info the post and then delete the post 
    @deletepost =  Message.all.find(params[:id])

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def message_params
      params.require(:message).permit(:title, :caption, :image)
    end

  
end
