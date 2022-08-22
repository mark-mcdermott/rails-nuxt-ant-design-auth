# CUSTOM SEED TASK 
# Allows Multiple Seed Files
#
# In order to run specific seed file, you can just run rake db:seed:seed_file_name
# To run all the seeds file with order in that db/seeds folder, run rake db:seed:all
#
# from # from https://stackoverflow.com/a/56594383 7/27/22

namespace :db do
  namespace :seed do

    Dir[File.join(Rails.root, 'db', 'seeds', '*.rb')].each do |filename|
      task_name = File.basename(filename, '.rb').intern

      task task_name => :environment do
        load(filename)
      end
    end

    task :all => :environment do
      Dir[File.join(Rails.root, 'db', 'seeds', '*.rb')].sort.each do |filename|
        load(filename)
      end
    end

  end
end