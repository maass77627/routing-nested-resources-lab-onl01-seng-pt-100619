class SongsController < ApplicationController
  def artists_index
    @song = Song.find(params[:id])
    @artists = @song.artists
    render template: 'artists/index'
  end

  def artist
   @song = Song.find(params[:id])

   # Note that because ids are unique by table we can go directly to
   # Post.find — no need for @author.posts.find...
   @artist = Artist.find(params[:artist_id])
   render template: 'artists/songs'
 end

  def show
    @song = Song.find(params[:id])
  end

  def new
    @song = Song.new
  end

  def create
    @song = Song.new(song_params)

    if @song.save
      redirect_to @song
    else
      render :new
    end
  end

  def edit
    @song = Song.find(params[:id])
  end

  def update
    @song = Song.find(params[:id])

    @song.update(song_params)

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private

  def song_params
    params.require(:song).permit(:title, :artist_name)
  end
end
