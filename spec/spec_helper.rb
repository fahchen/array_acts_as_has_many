Bundler.require(:default, :development)

require 'array_acts_as_has_many'

#$:.unshift(File.dirname(__FILE__) + '/fixtures')
Dir[File.dirname(__FILE__) + '/fixtures/*.rb'].each { |f| require f }

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.before(:suite) do |suite|
    ActiveRecord::Base.establish_connection(
      adapter: 'postgresql',
      encoding: 'unicode',
      database: 'postgres'
    )

    connection_config = {
      adapter: 'postgresql',
      encoding: 'unicode',
      database: 'array_acts_as_has_many_test'
    }

    ActiveRecord::Base.connection.create_database('array_acts_as_has_many_test', encoding: 'unicode') rescue nil
    ActiveRecord::Base.establish_connection(connection_config)
    begin
      connection = ActiveRecord::Base.connection
      connection.execute("SELECT 1")
    rescue
      puts '-' * 80
      puts "[FATAL] Unable to connect to database array_acts_as_has_many_test. Please run:\n\n    createdb array_acts_as_has_many_test"
      puts '-' * 80
      raise ActiveRecord::NoDatabaseError.new "Unable to connect to database array_acts_as_has_many_test. Please run:\n\n    createdb array_acts_as_has_many_test"
    end

    ActiveRecord::Migrator.migrations_paths = []
    ActiveRecord::Migration.verbose = false
    ActiveRecord::Schema.define(:version => 1) do
      create_table :zoos, force: :cascade do |t|
        t.integer  "dog_ids", default: [], array: true
        t.integer  "cat_ids", default: [], array: true
      end

      create_table :dogs, force: :cascade
      create_table :cats, force: :cascade
    end

  end
  config.after(:suite) do |suite|
    ActiveRecord::Base.connection.drop_database('array_acts_as_has_many_test') rescue nil
  end
end

