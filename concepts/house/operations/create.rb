require 'securerandom'

class House < Sequel::Model(DB)
  class Create < Trailblazer::Operation
    extend Contract::DSL

    step Model(House, :new)
    step Contract::Build()
    step Contract::Validate()
    step :set_timestamps
    step Contract::Persist()
    step :log_success
    failure  :log_failure


    def log_success(options, params:, model:, **)
      LOGGER.info "[#{self.class}] Created house with params #{params.to_json}. House: #{House::Representer.new(model).to_json}"
    end

    def log_failure(options, params:, **)
      LOGGER.info "[#{self.class}] Failed to create house with params #{params.to_json}"
    end
  end
end