class SendEmailJob < ApplicationJob
  queue_as :default

  def perform(*args)
    puts " ======== ENVIANDO EMAIL ======== "
    
    sleep 10
    puts " ======== EMAIL ENVIADO ======== "
  end
end
