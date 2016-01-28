require 'investment_tracking_infrastructure/db'
require 'investment_tracking_domain/domain/investments/investor'

module Investments
  class InvestorRepository
    def initialize(args = {})
      @db = args.fetch(
        :db,
        InvestmentTracking::DB.database[:investors]
      )
    end

    def create_investor(investor)
      @db.insert(name: investor.name)
    end
  end
end
