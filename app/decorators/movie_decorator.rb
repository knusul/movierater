class MovieDecorator < Draper::Decorator
  def average_rating
    object.ratings.average(:score)
  end

  def rating_by(user)
    object.ratings.where(:user => user).first.try :score
  end
end
