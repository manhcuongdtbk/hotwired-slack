module Dashboard
  class ChannelsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_channel, only: %i[show edit update destroy]

    def index
      @channels = Channel.all
    end

    def show; end

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
