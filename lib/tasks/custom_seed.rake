# frozen_string_literal: true

# based on the file with the same name in `db/seeds/*.rb`
namespace :db do
  namespace :seed do
    Dir[Rails.root.join('db', 'seeds', '*.rb')].each do |filename|
      next unless File.exist?(filename)

      task_name = File.basename(filename, '.rb')

      desc "Seed #{task_name}"
      task task_name.to_sym => :environment do
        load(filename)
      end
    end
  end
end
