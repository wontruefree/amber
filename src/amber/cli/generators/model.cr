module Amber::CLI
  class Model < Generator
    command :model
    property migration : Generator
    property model : Generator

    def initialize(name, fields)
      super(name, fields)
      case config.model
      when "clear"
        @migration = ClearMigration.new(name, fields)
        @model = ClearModel.new(name, fields)
      when "crecto"
        @migration = CrectoMigration.new(name, fields)
        @model = CrectoModel.new(name, fields)
      else # "granite"
        @migration = GraniteMigration.new(name, fields)
        @model = GraniteModel.new(name, fields)
      end
    end

    def render(directory)
      migration.render(directory)
      model.render(directory)
    end
  end
end
