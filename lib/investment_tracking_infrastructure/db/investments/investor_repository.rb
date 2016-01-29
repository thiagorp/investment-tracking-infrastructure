require 'investment_tracking_infrastructure/db'
require 'investment_tracking_domain/domain/investments/investor'

module Investments
  class InvestorRepository
    def initialize(args = {})
      @db = args.fetch(
        :db,
        InvestmentTracking::DB.database[:investors]
      )

      @investor_class = args.fetch(
        :investor_class,
        Investments::Investor
      )
    end

    def create_investor(investor)
      @db.insert(
        name: investor.name,
        created_at: DateTime.now,
        updated_at: DateTime.now
      )
    end

    def get_investor(investor_id)
      @investor_class.new(
        @db.select(:id, :name).where(id: investor_id).first.merge(repository: self)
      )
    end
  end
end
