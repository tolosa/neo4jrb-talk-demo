class Reviewed
  include Neo4j::ActiveRel

  to_class :Movie
  from_class :Person

  property :summary
  property :rating, type: Integer

  property :created_at
  property :updated_at

  validates :summary, :rating, presence: true
  validates :rating, numericality: { only_integer: true,
    greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
end
