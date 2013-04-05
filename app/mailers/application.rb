ProgramasSiconv.mailer :application do
  
  email :admin do |message|
    from         ENV['EMAIL_USER_NAME']
    to           ENV['EMAIL_USER_NAME']
    content_type :text
    subject      message[:subject]
    body         message[:body]
  end
  
end
