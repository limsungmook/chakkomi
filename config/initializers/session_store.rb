# Be sure to restart your server when you modify this file.

Chakkomi::Application.config.session_store :cookie_store, :key => '_chakkomi_session'

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
Chakkomi::Application.config.session_store :active_record_store

Chakkomi::Application.config.session = {
  :key          => '_chakkomi_session',     # name of cookie that stores the data
  :domain       => nil,                         # you can share between subdomains here: '.communityguides.eu'
  :expire_after => 1.month,                     # expire cookie
  :secure       => false,                       # fore https if true
  :httponly     => true,                        # a measure against XSS attacks, prevent client side scripts from accessing the cookie
  
  :secret      => 'b8b291c67a199dd07025cbc4bc24a91787d1c90cd38997c5f513ec2e5f85fcc0a9005d3462a68177f30e712281ba88752448c45c1883d6c4c6d3e9b89d0bcacc'
}
