module Discord
  class Client
    def self.call(content:)
      HTTParty.post(
        ENV.fetch('DISCORD_WEBHOOK_URL'),
        body: { content: content }.to_json,
        headers: { "Content-Type" => "application/json" }
      )
    end
  end
end
