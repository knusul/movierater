json.array!(@movies) do |movie|
  json.extract! movie, :id, :title, :description
  json.rating movie.ratings.average(:score)
  json.url movie_url(movie, format: :json)
end
