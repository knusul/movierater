json.array!(@movies) do |movie|
  json.extract! movie, :id, :title, :description, :category
  json.rating movie.decorate.rating_by(current_user)
  json.totalRating movie.decorate.average_rating
  json.url movie_url(movie, format: :json)
end
