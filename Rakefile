require 'rake/testtask'

Rake::TestTask.new do |t|
  t.pattern = 'test/**/*_test.rb'
  t.libs.push 'test'
end

namespace :db do
  desc 'Run database migrations'
  task :migrate, [:version] do |t, args|
    require 'sequel'

    Sequel.extension :migration
    db = Sequel.connect(ENV.fetch('DATABASE_URL'))

    if args[:version]
      puts "Migrating to version #{args[:version]}"
      Sequel::Migrator.run(db, 'db/migrations', target: args[:version].to_i)
    else
      puts 'Migrating to latest'
      Sequel::Migrator.run(db, 'db/migrations')
    end
  end
end

task default: :test
