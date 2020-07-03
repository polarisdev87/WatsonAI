# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

ENV['SSL_CERT_FILE'] = Rails.root.to_s+"/cacert.pem"
ENV['EXCON_DEBUG'] = "true"
