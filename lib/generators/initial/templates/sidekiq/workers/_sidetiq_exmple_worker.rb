# Running every night
#
# class SidetiqExampleWorker
#   include Sidekiq::Worker
#   include Sidetiq::Schedulable
#
#   recurrence { daily }
#
#   def perform
#   end
# end
