class Tutor < ApplicationRecord
  has_many :courses
  # automatically update index upon save on model
  include Elasticsearch::Model
  # include Elasticsearch::Model::Callbacks
  def to_indexed_json
    to_json( include: { courses: { only: [:code, :course_name, :description] } } )
  end
end
