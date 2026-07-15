module Discord
  class DiscordNotificationWorker
    include Sidekiq::Worker

    def perform(content)
      Discord::Client.call(content: content)
    end
  end
end
