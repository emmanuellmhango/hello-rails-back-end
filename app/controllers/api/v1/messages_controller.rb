class Api::V1::MessagesController < ApplicationController
  before_action :set_api_v1_message, only: %i[show update destroy]

  # GET /api/v1/messages
  def index
    @greeting = Message.order('RANDOM()').first

    render json: { message: @greeting.message }
  end

  # GET /api/v1/messages/1
  def show
    render json: @api_v1_message
  end

  # POST /api/v1/messages
  def create
    @api_v1_message = Api::V1::Message.new(api_v1_message_params)

    if @api_v1_message.save
      render json: @api_v1_message, status: :created, location: @api_v1_message
    else
      render json: @api_v1_message.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/messages/1
  def update
    if @api_v1_message.update(api_v1_message_params)
      render json: @api_v1_message
    else
      render json: @api_v1_message.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/messages/1
  def destroy
    @api_v1_message.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_api_v1_message
    @api_v1_message = Api::V1::Message.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def api_v1_message_params
    params.require(:message).permit(:message)
  end
end
