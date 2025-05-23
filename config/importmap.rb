# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "bootstrap", to: "bootstrap.min.js", preload: true
pin "@popperjs/core", to: "popper.js", preload: true
pin "flatpickr" # @4.6.13
pin "mapbox-gl", to: "https://cdn.skypack.dev/mapbox-gl"
pin "process" # @2.1.0

pin "@rails/activestorage", to: "@rails--activestorage.js" # @8.0.200
# config/importmap.rb
pin "cloudinary", to: "https://cdn.jsdelivr.net/npm/cloudinary-core@2.11.4/cloudinary-core-shrinkwrap.min.js"
