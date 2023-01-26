require 'uri'
require 'net/http'
require 'openssl'
require 'json'

class SongsController < ApplicationController
  before_action :set_song, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :current_user, only: [:edit, :update, :destroy]

  # GET /songs or /songs.json
  def index
    @songs = current_user.songs.paginate(:page => params[:page], :per_page => 10)
    
  end

  # GET /songs/1 or /songs/1.json
  def show
  end

  # GET /songs/new
  def new
    #@song = Song.new
    @song = current_user.songs.build
  end

  # GET /songs/1/edit
  def edit
  end

  # POST /songs or /songs.json
  def create
    #@song = Song.new(song_params)
    @song = current_user.songs.build(song_params)

    respond_to do |format|
      if @song.save
        format.html { redirect_to song_url(@song), notice: "Song was successfully created." }
        format.json { render :show, status: :created, location: @song }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /songs/1 or /songs/1.json
  def update
    respond_to do |format|
      if @song.update(song_params)
        format.html { redirect_to song_url(@song), notice: "Song was successfully updated." }
        format.json { render :show, status: :ok, location: @song }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /songs/1 or /songs/1.json
  def destroy
    @song.destroy

    respond_to do |format|
      format.html { redirect_to songs_url, notice: "Song was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # Post
  def add
    @playlist = Playlist.find(params[:playlist_id])
    song_id = params[:song_id].values[0]
    @song = Song.find(song_id)
    logger.info("#{@playlist.name}")
    logger.info("#{@song.artist_id}")

    song_hash = { "song_id" => song_id}

    @playlist_track = @playlist.songs.new(song_hash)

    if @playlist_track.save
      format.html { redirect_to playlist_url(@playlist), notice: "Song was successfully added." }
      format.json { render :show, status: :created, location: @playlist }
    else
      logger.info("Something went wrong")
    end

  end

  def getcover
    song_id = params[:song_id].values[0]
    puts song_id

    @song = Song.find(song_id) 

    query = @song.album + " " + @song.artist_id

    url = url = URI("https://spotify23.p.rapidapi.com/search/?q=#{query}&type=multi&offset=0&limit=10&numberOfTopResults=5")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    request["X-RapidAPI-Key"] = '07a612c820mshbce6f1d3dfbc143p173c8djsn817514da8835'
    request["X-RapidAPI-Host"] = 'spotify23.p.rapidapi.com'

    response = http.request(request)
    
    data = JSON.parse(response.body)

    track_data = data['albums']['items'][0]['data']

    imageurl = track_data['coverArt']['sources'][0]['url']

    render inline: "<%= image_tag '#{imageurl}' %>"
  end

  def getvideo
    song_id = params[:song_id].values[0]
    puts song_id

    @song = Song.find(song_id) 

    query = @song.title
    
    url = URI("https://youtube-search-results.p.rapidapi.com/youtube-search/?q=#{query}")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    request["X-RapidAPI-Key"] = '07a612c820mshbce6f1d3dfbc143p173c8djsn817514da8835'
    request["X-RapidAPI-Host"] = 'youtube-search-results.p.rapidapi.com'

    response = http.request(request)
    
    data = JSON.parse(response.body)

    videourl = data['items'][0]["url"]
    videourl['watch?v='] = 'embed/'

    render inline: "<iframe src=#{videourl} width='1000px' height='600px'>"
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_song
      @song = Song.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def song_params
      params.require(:song).permit(:title, :genre, :release_data, :artist_id, :album, :playlist_id)
    end
end
