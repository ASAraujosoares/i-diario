namespace :db do
  desc "Migrate the databases"
  task migrate_dbs: :environment do

    # Ajusta ActiveRecord::Migrations.migrations_paths pois ele simplesmente chumba o path db/migrate e ignora as configurações da aplicação
    paths = Educacao::Application.config.paths['db/migrate'].expanded

    ActiveRecord::Migration.verbose = ENV["VERBOSE"] ? ENV["VERBOSE"] == "true" : true
    context = ActiveRecord::MigrationContext.new(paths)
    context.migrate(ENV["VERSION"] ? ENV["VERSION"].to_i : nil) do |migration|
      ENV["SCOPE"].blank? || (ENV["SCOPE"] == migration.scope)
    end

    Entity.find_each(batch_size: 100) do |entity|
      entity.using_connection do
        puts "Migrating db: #{entity.domain}"

        ActiveRecord::Migration.verbose = ENV["VERBOSE"] ? ENV["VERBOSE"] == "true" : true
        context = ActiveRecord::MigrationContext.new(paths)
        context.migrate(ENV["VERSION"] ? ENV["VERSION"].to_i : nil) do |migration|
          ENV["SCOPE"].blank? || (ENV["SCOPE"] == migration.scope)
        end
      end
    end
  end

  namespace :migrate do
    task :down_dbs => [:environment, :load_config] do
      raise "VERSION is required - To go down one migration, use db:rollback" if ENV["VERSION"] && ENV["VERSION"].empty?
      version = ENV['VERSION'] ? ENV['VERSION'].to_i : nil
      paths = Educacao::Application.config.paths['db/migrate'].expanded

      context = ActiveRecord::MigrationContext.new(paths)
      context.run(:down, version)

      Entity.find_each(batch_size: 100) do |entity|
        entity.using_connection do
          puts "Migrating db: #{entity.domain}"

          context = ActiveRecord::MigrationContext.new(paths)
          context.run(:down, version)
        end
      end
    end

    task run_specific_tenant: :environment do
      begin
        Entity.find_by_name(ENV["TENANT"].to_sym).using_connection do
          paths = Educacao::Application.config.paths['db/migrate'].expanded
          ActiveRecord::Migration.verbose = true

          puts "Migrating db: #{Entity.current.domain}"

          context = ActiveRecord::MigrationContext.new(paths)
          context.migrate
        end
      rescue Exception => e
        puts "Database #{ENV["TENANT"]} not found"
      end
    end
  end
end

task('db:migrate').clear.enhance ['db:migrate_dbs']
task('db:migrate:down').clear.enhance ['db:migrate:down_dbs']
