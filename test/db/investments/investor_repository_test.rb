require 'timecop'
require 'test_helper'
require 'investment_tracking_domain/test_helpers/minitest/investments/roles/investor_repository_role_test'
require 'investment_tracking_infrastructure/db/investments/investor_repository'

class InvestorRepositoryTest < MiniTest::Test
  include Investments::InvestorRepositoryRoleTest

  def setup
    Timecop.freeze
  end

  def teardown
    Timecop.return
  end

  def test_it_creates_an_investor
    db = MiniTest::Mock.new
    db.expect :insert, 123, [create_investor_params.merge(timestamp_params)]

    investor_id = Investments::InvestorRepository.new(
      investor_repository_params(db: db)
    ).create_investor(fake_investor)

    db.verify
    assert_equal investor_id, 123
  end

  def test_it_gets_an_investor
    # Setup
    db_return_params = { id: 123, name: 'Investor Name' }
    investor_class = MiniTest::Mock.new
    db = MiniTest::Mock.new
    repository = Investments::InvestorRepository.new(
      investor_repository_params(
        investor_class: investor_class,
        db: db
      )
    )

    investor_class.expect(
      :new,
      'fetched investor',
      [
        db_return_params.merge(repository: repository)
      ]
    )

    db.expect :select, db, [:id, :name]
    db.expect :where, db, [id: 134]
    db.expect :first, db_return_params

    # Exercise
    investor = repository.get_investor(134)

    # Verify
    investor_class.verify
    db.verify
    assert_equal investor, 'fetched investor'
  end

  def test_it_returns_nil_if_investor_is_not_found
    # Setup
    db = MiniTest::Mock.new
    repository = Investments::InvestorRepository.new(
      investor_repository_params(db: db)
    )

    db.expect :select, db, [:id, :name]
    db.expect :where, db, [id: 134]
    db.expect :first, nil

    # Exercise
    investor = repository.get_investor(134)

    # Verify
    db.verify
    assert_equal investor, nil
  end

  private

  def timestamp_params
    {
      created_at: DateTime.now,
      updated_at: DateTime.now
    }
  end

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
