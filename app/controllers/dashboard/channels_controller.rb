module Dashboard
  class ChannelsController < Dashboard::BaseController
    before_action :set_channel, only: %i[show edit update destroy]

    def index
      @channels = Channel.all
    end

    def show
      @channels_user = current_user.channels_users.find_by(channel: @channel)
      real_last_read_at = @channels_user&.last_read_at # user do read at least 1 message
      fake_last_read_at = 1.year.ago # user didn't read any message
      @last_read_at = real_last_read_at || fake_last_read_at
      @channels_user&.touch(:last_read_at)
    end

    def new
      @channel = Channel.new
    end

    def create
      @channel = Channel.new(channel_params)

      respond_to do |format|
        if @channel.save
          format.html { redirect_to dashboard_channel_url(@channel), notice: 'Channel was successfully created.' }
          # format.json { render :show, status: :created, location: @channel }
        else
          format.html { render :new, status: :unprocessable_entity }
          # format.json { render json: @channel.errors, status: :unprocessable_entity }
        end
      end
    end

    def edit; end

    def update
      respond_to do |format|
        if @channel.update(channel_params)
          format.html { redirect_to dashboard_channel_url(@channel), notice: 'Channel was successfully updated.' }
          # format.json { render :show, status: :ok, location: @channel }
        else
          format.html { render :edit, status: :unprocessable_entity }
          # format.json { render json: @channel.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @channel.destroy

      respond_to do |format|
        format.html { redirect_to dashboard_channels_url, notice: 'Channel was successfully destroyed.' }
        # format.json { head :no_content }
      end
    end

    private

    def set_channel
      @channel = Channel.find(params[:id])
    end

    def channel_params
      params.require(:channel).permit(:name)
    end
  end
end
