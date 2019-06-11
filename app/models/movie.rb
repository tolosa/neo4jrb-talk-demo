class Movie
  include Neo4j::ActiveNode

  property :title
  property :tagline
  property :released, type: Integer

  property :created_at
  property :updated_at

  validates :title, :released, presence: true
  validates :released, numericality: { only_integer: true }
end
