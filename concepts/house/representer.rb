require 'roar/decorator'
require 'roar/json'

class House < Sequel::Model(DB)
  class Representer < Roar::Decorator
      include Roar::JSON
      defaults render_nil: true

      property :id
      property :user_id
      property :title
      property :address
      property :key
      property :created_at
      property :updated_at
  end

  class OwnerRepresenter < Roar::Decorator
    include Roar::JSON
    defaults render_nil: true

    property :id
    property :user_id
    property :title
    property :address
    property :key
    property :secret
    property :created_at
    property :updated_at
  end
end