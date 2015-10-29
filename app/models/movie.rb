class Movie < ActiveRecord::Base
    def self.all_ratings
        Hash['G','PG','PG-13','R']
        all_ratings = Movie.order(:rating).pluck(:rating).uniq
        all_ratings.compact
    end
    
    # def self.movies(filters, sort_field)
    #     return self.order(sort_field) if not filters
    #     self.where({:rating => filters}).order(sort_field)
    # end
    
    # def self.ratings
    #     self.pluck(:rating).uniq
    # end
    
    # def self.set_options(params, session)
    #     setup = { :redirect_to => false }
        
    #     setup[:ratings] = if params[:ratings]
        
    #     if params[:ratings].kind_of? Hash
    #         params[:ratings].keys
    #     else
    #         params[:ratings]
    #     end
    # elsif session[:ratings]
    #     setup[:redirect] = true
    #     session[:ratings]
    # else 
    #     self.ratings
    # end
    
    # setup[:order_by] = if params[:order_by]
    #     params[:order_by]
    # elsif session[:order_by]
    #     setup[:redirect] = true
    #     session[:order_by]
    # else
    #     nil
    # end
    #     setup
    # end
    
    # def self.all_ratings
    #     an_array = Array.new
    #     self.select("rating").uniq.each {|x| an_array.push(x.rating)}
    #     an_array.sort.uniq
    # end
    
end
