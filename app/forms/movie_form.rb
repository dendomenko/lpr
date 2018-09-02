class MovieForm
  include ActiveModel::Model

  attr_accessor :title, :description, :year, :video_genres

  validates :title, :description, :year, presence: true
end
