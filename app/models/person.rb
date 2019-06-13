class Person
  include Neo4j::ActiveNode

  property :name
  property :born, type: Integer

  property :created_at
  property :updated_at

  validates :name, :born, presence: true
  validates :born, numericality: { only_integer: true }

  has_many :out, :acted_in, type: :ACTED_IN, model_class: :Movie
  has_many :out, :reviews, rel_class: :Reviewed
end
