require 'sequel'

module InvestmentTracking
  module DB
    def self.database
      @@DATABASE ||= Sequel.connect(ENV['DATABASE_URL'])
    end
  end
end
