class Movie < ActiveRecord::Base
    # set movie ratings ignoring non-alphanumerics
    def self.ratings
        %w[G PG PG-13 R]
    end
end
