# TL;DR

The **master** branch is the fully configured template, ready to be used as the starting point of a project.

Other branches:
* **rails-new**: The result of `rails new foundation` - you can add components individually by basing a new branch on this branch and then merging the components that you want. A minimal controller and view for `home#index` is included and set as the default route.
* **add-bootstrap**:
* **add-navbar**:
* **add-devise**:
* **add-rails-settings**:
* **add-fontawesome**:

# How it was built

## Base Rails App

Create a new Rails app:

`rails new foundation` (branch: **rails-new**)

`rails g controller home index`

### home#index

For now, an empty `index` method and a trivial `views/home/index.html.erb` will do the trick:

```ruby
def index
end
```

```html
<h1>Foundation</h1>
```

The home controller gives us just enough to set up and test the other components and a target for Devise.

### [Bulma](https://bulma.io)

Pure CSS, no JavaScript.

## Roles

### References

* [Use Enum to Represent User Roles in your Database](https://medium.com/@stacietaylorcima/use-enum-to-represent-user-roles-in-your-database-1cd5424fb311) (March 2018)

## Permissions

* [PeterGate](https://github.com/elorest/petergate)
* [Pundit](https://github.com/varvet/pundit)
* [CanCanCan](https://github.com/CanCanCommunity/cancancan)

### References

* [Architecting a Roles & Permissions System Using Rails, GraphQL & React](https://www.atrium.co/inside-atrium/architecting-roles-permissions/) (August 2019) - Lessons: use a naming convention (premission names should be predictable, affirmative permissions only, bundling premissions into roles makes for a cleaner UI and easier reasoning about permissions - the cost is flexbility (you can't have permissions outside of your role), check authorization at the permission level - not the role level.

## Settings & Preferences

### [ledermann/rails-settings][ledermann]

Installed, but not used - e.g., no examples.

### [huacnlee/rails-settings-cached][huacnlee]

### References

[ledermann]: <https://github.com/ledermann/rails-settings>
[huacnlee]: <https://github.com/huacnlee/rails-settings-cached>

## Customizing

[How to rename rails controller and model in a project](https://stackoverflow.com/questions/11924124/how-to-rename-rails-controller-and-model-in-a-project)

## Other Resources

* [The Ultimate Intermediate Ruby on Rails Tutorial: Let’s Create an Entire App!](https://www.freecodecamp.org/news/lets-create-an-intermediate-level-ruby-on-rails-application-d7c6e997c63f/) (December 2017)
* [modern rails with webpacker and stimulus](https://michael.minton.io/2018/06/modern-rails-with-webpacker-and-stimulus.html) (July 2018) - and Bulma and [Stimulus][].

### Packages

* [Stimulus][]

[stimulus]: <https://stimulusjs.org>
