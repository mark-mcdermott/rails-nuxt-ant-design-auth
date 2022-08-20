class PrivateContentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_private_content, only: %i[ show update destroy ]

  # GET /private_contents
  # GET /private_contents.json
  def index
    @private_contents = PrivateContent.all
  end

  # GET /private_contents/1
  # GET /private_contents/1.json
  def show
  end

  # POST /private_contents
  # POST /private_contents.json
  def create
    @private_content = PrivateContent.new(private_content_params)

    if @private_content.save
      render :show, status: :created, location: @private_content
    else
      render json: @private_content.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /private_contents/1
  # PATCH/PUT /private_contents/1.json
  def update
    if @private_content.update(private_content_params)
      render :show, status: :ok, location: @private_content
    else
      render json: @private_content.errors, status: :unprocessable_entity
    end
  end

  # DELETE /private_contents/1
  # DELETE /private_contents/1.json
  def destroy
    @private_content.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_private_content
      @private_content = PrivateContent.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def private_content_params
      params.require(:private_content).permit(:name)
    end
end
