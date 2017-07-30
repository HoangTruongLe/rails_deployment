class FilesCleanupJob < ApplicationJob
  queue_as :cleanup_queue

  def perform(file)
    File.delete(file)
  end
end
