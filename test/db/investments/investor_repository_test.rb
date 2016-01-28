require 'test_helper'
require 'investment_tracking_domain/test_helpers/minitest/investments/roles/investor_repository_role_test'
require 'investment_tracking_infrastructure/db/investments/investor_repository'

class InvestorRepositoryTest < MiniTest::Test
  include Investments::InvestorRepositoryRoleTest

  def test_it_creates_an_investor
    db = MiniTest::Mock.new
    db.expect :insert, 123, [create_investor_params]

    investor_id = Investments::InvestorRepository.new(
      investor_repository_params(db: db)
    ).create_investor(fake_investor)

    db.verify
    assert_equal investor_id, 123
  end

  private

  def investor_repository_params(override = {})
    {
      db: MiniTest::Mock.new
    }.merge(override)
  end

  def create_investor_params
    {
      name: 'Fake investor'
    }
  end

  def fake_investor
    @fake_investor ||= OpenStruct.new(create_investor_params)
  end

  def repository
    Investments::InvestorRepository.new(
      db: MiniTest::Mock.new
    )
  end
end
