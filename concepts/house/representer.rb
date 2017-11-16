require 'roar/decorator'
require 'roar/json'

class House < Sequel::Model(DB)
  class Representer < Roar::Decorator
      include Roar::JSON

      property :id
      property :title
      property :address
      property :key
      property :created_at
      property :updated_at
  end
end