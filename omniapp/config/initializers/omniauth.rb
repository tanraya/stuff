# http://blog.railsrumble.com/blog/2010/10/08/intridea-omniauth
# https://github.com/railsapps/rails3-mongoid-omniauth/wiki/Tutorial
# https://github.com/intridea/omniauth/pull/217
# http://stackoverflow.com/questions/3977303/omniauth-facebook-certificate-verify-failed
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, "joNXMpuGluPT3YhAXxggQ", "KdAdq23xi4DP3MLZ2ldWUXI4ZvjjlG5HQiu4z49Ko", :client_options => {:ssl => { :ca_file => "#{Rails.root}/config/ca-bundle.crt" }}
  provider :facebook, '219133284794448', '126aabc8aa6fb5f961c917dc38c520be', {:client_options => {:ssl => { :ca_file => "#{Rails.root}/config/ca-bundle.crt" }}, :scope => 'publish_stream,email'}
end
