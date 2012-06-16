require 'dragonfly/rails/images'
require 'dragonfly-minimagick'

# Retrieve Dragonfly Rack app
app = Dragonfly::App[:files]

# Configure Dragonfly with mini_magick
Dragonfly[:files].configure_with(:minimagick)