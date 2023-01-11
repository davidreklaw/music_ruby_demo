class PlaylistTrackController < ApplicationController

    def index
    end

    def show

    end

    def create
        @playlist_tracks = PlaylistTrack.new(playlist_track_params)

        if @playlist_tracks.save
            render json: ['Successfully Added']
        else
            render json: @playlist_tracks.errors.full_messages, status: 422
        end
    end
    
    def destroy
        @playlist_tracks = PlaylistTrack.where(playlistt_id: params[:playlist_id], params[:song_id])
        @playlist_tracks.destroy
        render json: ['Successfully Removed']
    end

    private

    def playlist_track_params
        params.required(:playlist_track).permit(:playlist_id, :song_id)
    end
end
