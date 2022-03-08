module Dashboard
  class MessagesController < Dashboard::BaseController
    before_action :set_channel
    before_action :set_message, only: %i[show edit update]

    def show; end

    def create
      @message = @channel.messages.new(message_params)

      respond_to do |format|
        if @message.save
          format.turbo_stream do
            UnreadsChannel.broadcast_to(@channel, {})
            redirect_to dashboard_channel_url(@channel), notice: 'Message was successfully created'
          end
        else
          format.turbo_stream do
            # TODO: autofocus the message input target after replacing the message form
            render turbo_stream: turbo_stream.replace(@message,
                                                      partial: 'dashboard/messages/form',
                                                      locals: { channel: @message.channel, message: @message })
          end
        end
      end
    end

    def edit; end

    def update; end

    private

    def set_channel
      @channel = current_user.channels.find(params[:channel_id])
    end

    def message_params
      params.require(:message).permit(:body).merge(user: current_user)
    end

    def set_message
      @message = @channel.messages.find(params[:id])
    end
  end
end
