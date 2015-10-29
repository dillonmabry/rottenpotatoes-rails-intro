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
    
     
    @movies = Movie.all.order(params[:sort])
    @sort_column = params[:sort]
    # ratings sorting
    @all_ratings = Movie.all_ratings
    @selected_ratings = (params[:ratings].present? ? params[:ratings] : [])
    @movies = @movies.where(:rating => params[:ratings]) if params[:ratings].present?
    
    # session[:ratings] = @selected_ratings
    # session[:order_by] = @selected_ratings[:order_by]

    
  # setup = Movie.set_options(params, session) 
  
  # if setup[:redirect]
  #   flash.keep
    
  #   redirect_to(:action => params[:action], :controller => params[:controller],
  #     :ratings => setup[:ratings], :order_by => setup[:order_by])
  # end
  
  # @ratings = Movie.ratings
  # @filters = setup[:ratings]
  # @movies = Movie.movies(@filters, setup[:order_by])
  
  # session[:ratings] = setup[:ratings]
  # session[:order_by] = setup[:order_by]
  
  # @all_ratings = Movie.all_ratings
  # session[:sort] ||= 'id'
  # session[:selected_ratings] ||= Movie.all_ratings
  
  # redirect = false
  
  # if !params.has_key?(:sort)
  #   sort = session[:sort]
  #   redirect = true
  # else 
  #   sort = params[:sort]
  # end
  
  # @movies = Movie.movies(@selected_ratings, sort[:order_by])
  
  # if !params.has_key?(:ratings)
  #   @selected_ratings = session[:selected_ratings]
  #   redirect = true
  # else 
  #   @selected_ratings = params[:ratings]
  # end
  
  # if redirect
  #   rHash = Hash.new
  #   rHash['sort'] = sort
  #   @selected_ratings.each do |r|
  #     k = 'ratings[#{r}]'
  #     rHash[k] = r
  #   end
  
  #   flash.keep
  #   redirect_to movies_path :ratings => @selected_ratings, :sort => sort
  #   return
  # end
    
  # if sort == 'title'
  #   @title_sort = 'hilite'
  # end
  
  # if sort == 'rating'
  #   @rating_sort = 'hilite'
  # end
  
  # session[:sort] = sort
  # session[:selected_ratings] = @selected_ratings
    
    
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
