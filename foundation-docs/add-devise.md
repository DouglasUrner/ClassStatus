# User Accounts

## [Devise](https://github.com/heartcombo/devise)

1. Find Devise on RubyGems.org and copy the Gemfile line. Add to your Gemfile just before the **group** sections.
1. `bundle install`
1. `rails g devise:install`
1. Do manual commands output by `devise:install`
1. `rails g devise user`
1. `rails db:migrate`
1. If it is running, restart the Rails server. Test to confirm that the app still loads.
1. `rails g devise:views` - if you need to edit the Devise views, otherwise, skip.

## References

* [User Authentication in Rails with Devise](https://www.youtube.com/watch?v=ef11ToOE4N0&list=PLGpsnWFCyASUdxcZl3AMarVRHIr05WKYV&index=12) (May 2015) - Good video adding **devise** to an existing Rails app.
* [Codeplace | User Authentication in Ruby on Rails using Devise](https://www.youtube.com/watch?v=ZEk0Jp2dThc&list=PLGpsnWFCyASUdxcZl3AMarVRHIr05WKYV&index=5) (January 2015) - Video starting from scratch. Adds SMTP method to mailer setup (send e-mail through a Gmail account or a similar service). Uses a **home** controller with an **index** action.
* [Using the Devise Gem to Handle Authentication in a Rails App](https://medium.com/swlh/https-medium-com-melee-santiago-using-devise-gem-to-handle-authentication-in-rails-app-538bbd231dde) (May 2019)
* [imhta/rails_6_devise_example](https://github.com/imhta/rails_6_devise_example)
* [Devise sign in/sign up in popup](https://stackoverflow.com/questions/32237818/devise-sign-in-sign-up-in-popup) (2015) - Converting Devise login forms to popups - AJAX and JSON.
