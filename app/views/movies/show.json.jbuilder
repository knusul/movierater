json.extract! @movie, :id, :title, :description, :created_at, :updated_at
json.rating @movie.decorate.rating_by current_user
json.totalRating @movie.decorate.average_rating
