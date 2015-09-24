class Movie < ActiveRecord::Base
  has_many :ratings, :dependent => :delete_all
end
