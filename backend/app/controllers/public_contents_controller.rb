class PublicContentsController < ApplicationController
  before_action :set_public_content, only: %i[ show update destroy ]

  # GET /public_contents
  # GET /public_contents.json
  def index
    @public_contents = PublicContent.all
  end

  # GET /public_contents/1
  # GET /public_contents/1.json
  def show
  end

  # POST /public_contents
  # POST /public_contents.json
  def create
    @public_content = PublicContent.new(public_content_params)

    if @public_content.save
      render :show, status: :created, location: @public_content
    else
      render json: @public_content.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /public_contents/1
  # PATCH/PUT /public_contents/1.json
  def update
    if @public_content.update(public_content_params)
      render :show, status: :ok, location: @public_content
    else
      render json: @public_content.errors, status: :unprocessable_entity
    end
  end

  # DELETE /public_contents/1
  # DELETE /public_contents/1.json
  def destroy
    @public_content.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_public_content
      @public_content = PublicContent.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def public_content_params
      params.require(:public_content).permit(:name)
    end
end
