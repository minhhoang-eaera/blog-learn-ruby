# Pin npm packages by running ./bin/importmap

# config/importmap.rb

# Pin npm packages by running ./bin/importmap pin <package>
pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js"
