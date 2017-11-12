# require './app/models/'
task :index_tutors => :environment do
  TutorIndexer.new.index
end
