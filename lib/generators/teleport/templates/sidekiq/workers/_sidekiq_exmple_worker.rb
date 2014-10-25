# Run with:
# SidekiqExampleWorker.perform_async(Post.id)
#
# class SidekiqExampleWorker
#   include Sidekiq::Worker
#
#   def perform(post_id)
#     Post.find(post_id).recreate_images
#   end
# end
