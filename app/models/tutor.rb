class Tutor < ApplicationRecord
  # automatically update index upon save on model
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
end
