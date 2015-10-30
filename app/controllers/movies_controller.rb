class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end
  
  def index
    
    # @movies = Movie.all.order(params[:sort])
    # @sort_column = params[:sort]
    # # ratings sorting
    # @all_ratings = Movie.all_ratings
    # @selected_ratings = (params[:ratings].present? ? params[:ratings] : [])
    # @movies = @movies.where(:rating => params[:ratings]) if params[:ratings].present?
    
    @all_ratings = Movie.ratings
    @movies = Movie.all
    
    # if the ratings params is not empty set session for selected ratings
    if !(params[:ratings].nil?)
      @selected_ratings = params[:ratings]
      session[:selected_ratings] = @selected_ratings
    end
    
    # if the sort params empty do nothing
    if params[:sort_column].nil?
      # do nothing
    # else set the session for the sorting params
    else
      session[:sort_column] = params[:sort_column]
    end
    
    # if the sorting params and ratings params is empty
    # if the session has been set with selected ratings
    if params[:sort_column].nil? && params[:ratings].nil? && session[:selected_ratings]
      @selected_ratings = session[:selected_ratings]
      @sort_column = session[:sort_column]
      flash.keep
      redirect_to movies_path(order_by: @sort_column, ratings: @selected_ratings)
    end
    
    if session[:selected_ratings]
      @movies = @movies.select { |item| session[:selected_ratings].include?(item.rating) }
    end

    # if the session is sort by title sort
    if session[:sort_column] == "title"
      @movies = @movies.sort! { |a,b| a.title <=> b.title }
      # highlight the instance variable
      @title_sort= "hilite"
    # if the session is sort by release date sort
    elsif session[:sort_column] == "release_date"
      @movies = @movies.sort! { |a,b| a.release_date <=> b.release_date }
      # highlight the instance variable
      @release_sort = "hilite"
    else
      # do nothing
    end
  
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
