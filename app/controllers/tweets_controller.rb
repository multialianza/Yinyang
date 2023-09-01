class TweetsController < ApplicationController
  before_action :set_tweet, only: %i[ show edit update destroy ]

  # GET /tweets or /tweets.json
  def index
    @tweets = Tweet.all

    @pagy, @tweets = pagy(Tweet.all) # Gema pagy

    @filtro = params[:buscar]
    if @filtro.present?
      @tweets = Tweet.search_full_text(@filtro)
    end
  end

  # GET /tweets/1 or /tweets/1.json
  def show
  end

  # GET /tweets/new
  def new
    @tweet = Tweet.new
  end

  # GET /tweets/1/edit
  def edit
    @tweet = Tweet.find(params[:id])
  end

  # POST /tweets or /tweets.json
  def create
    @tweet = Tweet.new(tweet_params)
  
    if @tweet.save
      redirect_to tweets_path, notice: "Tu Tweet ha sido creado con éxito."
    else
      render :new
    end
  end
  
  

  # PATCH/PUT /tweets/1 or /tweets/1.json
  def update
    @tweet = Tweet.find(params[:id])
    if @tweet.update(tweet_params)
      redirect_to tweets_path, notice: 'Tweet actualizado correctamente.'
    else
      render :edit
    end
  end
  

  # DELETE /tweets/1 or /tweets/1.json
  def destroy
    @tweet.destroy
    redirect_to tweets_path, notice: "Tweet eliminado con éxito"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tweet_params
      params.require(:tweet).permit(:description, :username)
    end
end
