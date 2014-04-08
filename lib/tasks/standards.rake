require_relative 'standards'

namespace :standards do
  desc "Load common core standards from ccssi dir"
  task :load, [:dir] => :environment do |task, args|
    CoreStandard.delete_all
    StandardsImport.new(args[:dir]).import
  end
end

