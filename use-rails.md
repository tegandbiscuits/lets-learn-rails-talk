# Let's Learn Rails

Note:
* Hi everyone, I'm Tegan
* I'm a software engineer at CodeClimate
* And today I'm going to talk to y'all about the framework, Ruby on Rails

<!-- TODO: add handles and a link to the presentation and demo code -->

---

# You Should Use Rails

Note:
* So I think you should use Rails
* Rails is a really powerful framework that lets you build complex web apps in a fast, yet sustainable way
* It's pretty big on the idea that you shouldn't need to bother thinking about the things that every web app does
  * Which helps you focus on what makes your product actually unique
* You can use it to build
  * Traditional multipage apps
  * APIs
  * Even microservices to an extent

---

## Lots of Tooling Out of the Box

* Testing <!-- .element: class="fragment" -->
* Database Interaction and Management <!-- .element: class="fragment" -->
* Sending & Receiving Transactional Emails <!-- .element: class="fragment" -->
* WebSockets <!-- .element: class="fragment" -->
* Background Jobs <!-- .element: class="fragment" -->

Note:
* Rails gives you a lot of tooling right out of the box
* Not an exhaustive list, but a few things I think that are significant...

---

## All The Patterns

Note:
* Beyond tooling, you also get loads of architecture patterns given to you
* Rails is big on the idea of convention over code
* Which is to say, you're able to operate in a pretty high level, and declarative way for a lot of common tasks
* Yet it's flexible enough that it's easy to break convention when you need to
* The benefit of this is that your code will be very organized and maintainable, and it's easier to find patterns to help you create your own abstractions
* Apart from keeping you from reinventing the wheel, it also helps other developers (or you in the future) pick up a codebase
  * The basic stuff can be assumed knowledge

<!-- conventions are how rails is able to do it's magic -->

---

## Great Third Party Tooling

Note:
* Rails is a pretty established framework, which at this point means that a lot of third party packages are also mature and battle tested
  * A fair bit are even maintained by big companies, like Shopify, GitHub, or ThoughtBot
* There's a huge range of packages out there in Ruby
  * Big, complex things like user management, or ecommerce tools
  * Or small things like validating phone numbers
* The community also has a really big testing focus, so nearly everything is testable in a confident way

---

## Hit The Ground Running

Note:
* So to reiterate, because you get so many patterns and tooling out of the box, you can really hit the ground running, and prevent answering decisions that have already been answered by other people
* Which in turn helps you deliver things fast

---

## Useful For Many

Note:
* For how versatile it is, Rails is almost suspiciously easy to pick up and use
* So you could be a solo developer that doesn't have much backend experience, all the way up to a large scale company, like GitHub or Shopify
* Also, Rails is also structured in a way, that I think, makes it easy to avoid stepping on each other's toes as more developers work on a codebase at one time

---

## Ruby Is Great

Note:
* Into more subjective territory, I also feel like Ruby in it's own right is a plus to using Rails
* It's a really fun language to work with
* It was literally made to make developers happy
* It's easy to write code that does complicated things in a way that's minimal, expressive and clear

---

## The Community is Fantastic

Note:
* More broadly, in my experience, the Ruby community itself is incredibly nice and accepting of people
* There's even an acronym MINASWAN which is "Matz [the creator of ruby] is nice and so we are nice."
* So I think it's a very positive environment for developers to be in
* If you want to feel connected, RubyConf and RailsConf are large conferences that happen yearly
* And there's loads of smaller user groups around

---

# Let's Build Something

Note:
* Alright, let's build something
* Hopefully I've enticed you enough that you're curious to see some of this stuff in action
* So let's make...

---

## A Todo App

* Tasks that belong to task groups <!-- .element: class="fragment" -->
* Tests <!-- .element: class="fragment" -->
* Data seeding <!-- .element: class="fragment" -->

Note:
* ...A todo app
* Very fancy and original
* A sort of overview of what we'll cover here...
* For the sake of time and simplicity, the UI is going to be a little rough

<!-- TODO: add a demo video -->

---

# Ruby Primer

Note:
* But first, I want to make a small diversion
* If this is your first experience with Rails, there's a good chance you're not very familiar with Ruby
* It's a pretty intuitive language, but I want to go over a few things that will make it easier to understand the code that you'll see

---

## Packages

<!-- TODO: get rubygems and bundler logos -->

Note:
* Packages are called gems
* They can be installed globally or in a project with a `Gemfile`
* Gemfiles are managed using a tool called Bundler

---

## Some Things Can Be Implied/Omitted

Note:
* One of the more significant differences is the amount of syntax that can be implied or omitted


### Return Statements

```rb []
# no
def greet
  return "hello world"
end

# yes
def greet
  "hello world"
end
```

```rb []
# exiting early
def speak(is_cat)
  return "meow" if is_cat

  "woof"
end
speak(true)
#=> "meow"
speak(false)
#=> "woof"
```

Note:
* The return keyword for example
* Unless you want to exit a function early, you don't need to bother with it
* The last line is what will be returned


### Parenthesis

```rb []
def greet()
  "hello world"
end
# same as
def greet
  "hello world"
end
# with params
def greet_person(name)
  "hello #{name}"
end
```

```rb []
greet()
greet

greet_person("friends")
greet_person "friends"
```
<!-- .element: class="fragment" -->

Note:
* You also don't need to include parenthesis when declaring functions with no parameters
* You also don't need them when running functions (with or without parameters)


```rb []
greet_person(greet_person(greet()))
# can be expressed as

greet_person greet_person greet
# but please don't do this 🤢
```

Note:
* Please don't go to crazy with this, because this can get pretty confusing pretty fast


### Curly Braces For Hashes

_Only when the last argument of a function_

```rb []
def do_something(name, options)
  #
end

do_something("foo", { option_a: "meow", option_b: "woof" })
# same as
do_something("foo", option_a: "meow", option_b: "woof")
```

```rb []
# can also declare functions like
def do_something(name, option_a:, option_b:)
  # ...
end
# this will make both `option_a` and `option_b` required
```
<!-- .element: class="fragment" -->

Note:
* You don't always need to include the curly braces when passing a `Hash` as an argument
* Kind of relevant to mention, you can create keyword arguments like this

---

## Symbols

```rb
:i_am_a_symbol
```

Note:
* Ruby also has a type called a `Symbol`
* They're not unique to Ruby, but I don't think they're very common in other languages
* A symbol kind of sits between a string variable and a constant
* Typically end users won't see or interact with symbols (at least knowingly)
* They're generally used as arguments where you have a set amount of possible values
  * And by extension, also convey something isn't an arbitrary value better than a string


```rb []
def speak(tone = nil)
  greeting = "hello world"
  return greeting.upcase if tone == :loud

  greeting
end

speak
#=> "hello world"
speak(:loud)
#=> "HELLO WORLD"
```

Note:
* So in this example, we're saying argument `tone` isn't just a random string, it does something special when the value is the symbol `:loud`
* There's also a technical difference in that if you have multiple symbols of the same value, they'll all use the same space in memory
  * So they're more lightweight than strings
  * In practice, this knowledge has never been useful to me

---

## Functions Can Run Anywhere

_but still have contexts they are scoped to_

Note:
* One of the more powerful things about Ruby is that functions can run pretty much wherever
* This opens the door greatly for being able to do metapgramming


```rb []
def add_a_greeting(method_name)
  self.define_method(method_name) do
    puts "hello world"
  end
end

class Foo
  add_a_greeting(:greet)
end

Foo.new.greet
#=> "hello world"
```

Note:
* This is kind of an advance example, so it's fine if you don't completely understand it
* We've got a function called `add_a_greeting` that adds a method to whatever the current scope is
* So if we run `add_a_greeting` when declaring the class `Foo` it will add an instance method called `greet` to `Foo`
* Pretty powerful stuff

---

## Base setup

* Ruby (`rbenv` or `rvm`)
* Rails CLI (`gem install rails`)

Note:
* Ok, let's actually get into coding

* Obviously, you need Ruby on your system
  * Strongly recommend either `rbenv` or `rvm`
* Once you have one of those installed select a version of Ruby to use
  * This demo was made with using Ruby 3

* Next you're going to need the Rails CLI, which can be installed by running `gem install rails`
  * At this time, the current version if Rails is 7.0

---

# Create The Project

Note:
* Now we can move on to initializing the project


```sh
rails new planner --database postgresql
```

Note:
* This can be done using the `rails new` command

* Here we're saying the project will be called `planner`
* And we're going to use Postgres as the database for ActiveRecord to use
  * There's a number of different databases you can use but Postgres is usually the best choice
  * You can always change it later
  <!-- TODO: can you add multiple types of databases at once now? -->

* There's also a bunch of different flags you can pass, but I'm not going to get into those just yet

* Running this will
  * Create a `planner` directory with a bunch of files
  * Run `bundle install` to install the default gems

---

## A Note About JavaScript + Rails

Note:
* I have a quick aside about JavaScript and Rails that I want to make
* As much as I love Rails, the core Rails maintainers don't always have the best opinions in regards to frontend development

* The last few major versions of Rails have dramatically changed the default JavaScript setup
  * So it's a little wild
* Currently, they're big on using import maps
  * Which is fine if you aren't going too heavy into JavaScript, but if you want to transpile code or do anything advanced, I'd recommend setting up webpack or esbuild
* Rails also includes the JavaScript packages Turbo and Stimulus by default
  * In my opinion, these are pretty slick tools, that do pair well with Rails, however maybe shouldn't be there by default

* That said, to not slam you with information, I'm going to just leave everything as is
* However if you get into more frontend heavy work, you might want to take a second look at the Rails defaults

---

## Running Things

```sh[1|2-3|4]
cd planner
# with postgres (or whichever database) running
rails db:create # creates planner_development and planner_test
rails serve
```

<!-- TODO: hello world screenshot -->

```sh
rails test
```
<!-- .element: class="fragment" -->

<!-- TODO: bare test output screenshot -->

Note:
* Ok, let's get things running

* First, go to the directory of the project
* Then, we can run `rails db:create` to create the databases for our dev and test environments
* Lastly, run `rails serve`, and you should be able to go `localhost:3000` and see the hello world screen
  * You'll have to restart sometimes, but generally can just leave this running

* You can also run the tests
* There aren't any tests, but you should at least see there aren't errors with your environment

<!--
## Overview of Generated Things

Most code will live in `app` or `test`

* `assets`: You can throw things you want in your rails views here
* `channels`: Channels are essentially controllers for websockets
* `controllers`: Code that makes up your endpoints
* `helpers`: Simple functions used in views for outputting presentational stuff
* `jobs`: Single purpose classes that you can run as background tasks
* `mailers`: Code that builds and sends emails
* `models`: Code that represents data
* `views`: Templates that controllers render

ote:
* For mailers to work, they need to be plugged into an SMTP server
  * For local development, Mailhog is a really useful tool
* Models are usually database backed, but don't need to be
* Your views can create different output, such as HTML, JSON, even CSVs or plaintext
* There's a bunch of different templating languages you can use, but the default, ERB, is good and simple
-->

---

# Generate Task Group Model

Note:
* Now we've got things initialized, let's get to implementing stuff

* Tasks will belong to task groups, so lets create the task group model first
* This model will be pretty simple, basically only have a title attribute


```sh [|1|2|3|]
rails generate model TaskGroup \
  title:string \
  --skip-fixture
```

<!-- TODO: show what this generates -->

Note:
* Rails is handy and comes with a bunch of generators to spit out boilerplate code
  * You can even create your own generators

* We can run the model generator, specifying the model to be called `TaskGroup`

* Optionally, we can also use this syntax of `property_name:type` to generate more code for us
* So here we have one property called `title` that will be a `string`
* There's a bunch of types you can use
  * However you're a little limited by what database you use

* I also added the flag `--skip-fixture` because we don't want to use fixtures
* Fixtures are basically YAML representation of your database, that get loaded to the test database so you don't need to have as much setup code in your tests
* In theory this is good, but in practice fixtures are messy and annoying
  * I'll be showing a better alternative later on

<!-- TODO: make a slide for this -->
* After running this command a few files will be created.
* A database migration to create the table
* The ruby class for the model
* A test file for the class

* It's also worth pointing out that the generators are just for convenience, you don't need to use them

---

## Requiring Title in the Database

Note:
* We're going to make a small change to what this generated so that the `title` property is required


```rb [|6]
# migration file

class CreateTaskGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :task_groups do |t|
      t.string :title, null: false

      t.timestamps
    end
  end
end
```

Note:
* First we're going to open the migration file, and say the `title` column has a `null: false` constraint

---

## Requiring Title in the Ruby Class

Note:
* Next we're going to do the same thing, but in the Ruby class instead of the database


```rb [|4]
# app/models/task_group.rb

class TaskGroup < ApplicationRecord
  validates :title, presence: true
end
```

Note:
* In the `TaskGroup` class, we add this line that runs the `validates` method, which will make Rails aware that `title` is required

---

## Why Require Twice?

* Database Validation
  * Prevents manual updates from not having a name
  * Certain methods in Rails can skip validation
  * Get an idea of requirements just by looking at the data
* Rails Validation
  * Avoids DB requests that will fail
  * Adds methods to `TaskGroup` instances that are useful
  * Also checks for empty strings

Note:
* There's a few reasons why we're saying `title` is required in two places

* The database is a stronger enforcer of this requirement
* It also makes it easy to get an idea of our app just by looking at the data

* However, doing the validation in Rails is more performant, since it can potentially save us a useless database call
* The Rails validation is also more helpful if a record is invalid
  * Both for you as a developer and for the end user

---

```sh
rails db:migrate
```

Note:
* With Postgres running, we can now do the migration

---

## Testing Task Group Model

Note:
* Let's throw together some tests for the model
* I'm not going to get too deep into testing since that's a big subject


```rb [|6-9|10-12|14-18]
# test/models/task_group_test.rb

require "test_helper"

class TaskGroupTest < ActiveSupport::TestCase
  setup do
    @task_group = TaskGroup.new(title: "test")
  end

  test "is valid" do
    assert @task_group.valid?
  end

  test "requires a title" do
    @task_group.title = nil
    assert_not @task_group.valid?
    assert_includes @task_group.errors, :title
  end
end
```
<!-- .element: class="r-stretch" -->

Note:
* Out of the box, Rails uses the Minitest framework, with additional helpers
* The test file goes in the `test` directory, but will have a similar path and filename to the thing under test
  * So in this case, it's `test/models/task_group_test.rb`

* First, we're going to build a task group, and set it to the instance variable `@task_group`
* This will happen before every test

* Next, we'll have a test to make sure it actually is valid as a control

* Then we test that setting title to `nil` makes the task group invalid


```sh
rails test
# or
rails test path/to/file_test.rb
```

<!-- TODO: show output -->

Note:
* You can run these with `rails test`
* You can also specify which test file to run if you want

---

# UI Setup


```erb [5-6]
<!-- app/views/layouts/application.html.erb (inside `head` element) -->

<head>
  <!-- ... -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
```

Note:
* To help style things, I'm going to add Bootstrap to the project
* To keep things simple, I'm going to just link to a CDN build

* Rails has a file called `application.html.erb` which is a layout template
* It will automatically surround our other pages
* It's possible to have multiple layout templates
  * One for authorized and one for unauthorized for example

* So we can add these tags to the `head` of that file, and Bootstrap will be around for every page

---

## Notice Container

Note:
* While we're in our layout file, let's also setup the page layout and show any notices that come back


```erb[|4,12|5-9|11]
<!-- app/views/layouts/application.html.erb (inside `body` element) -->

<body>
  <div class="container">
    <% if notice %>
      <div class="alert alert-success" role="alert">
        <%= notice %>
      </div>
    <% end %>

    <%= yield %>
  </div>
</body>
```

Note:
* Add a Bootstrap container

* `notice` is a variable that controllers can set that tell the user something
  * Things like "item saved" or "item deleted"
* Something to point out is how some tags start with `<%` and some start with `<%=`
  * They both are for running Ruby code in the template, but when there is a `=` the return value will be added to the page

* `yield` is essentially where the individual templates for controllers will be added to the page

<!-- TODO: after this slide is a good place to remove turbolinks hello world cruft -->

---

# Creating a Controller <!-- .element: class="r-fit-text" -->

Note:
* We've got this model, but now we need to actually do something with it
* That will be the controller's job
* We could use a generator to scaffold things, but to we're going to do this one manually

<!-- TODO: should I give a sentence for what a controller is? -->


```rb []
# app/controllers/task_groups_controller.rb

class TaskGroupsController < ApplicationController
end
```

Note:
* Create a file `app/controllers/task_groups_controller.rb`, and corresponding class.

* Note that `TaskGroups` is plural
  * Controllers should have plural names, and models are singular
* Not every controller needs to correspond to a model, or vice-versa

---

## Scaffolding Controller Methods


```rb [|6-12|14, 16|14, 18|4]
# app/controllers/task_groups_controller.rb

class TaskGroupsController < ApplicationController
  before_action :set_task_group, except: [:index]

  def index; end

  def create; end

  def update; end

  def destroy; end

  private

  def task_group_params; end

  def set_task_group; end
end
```

Note:
* We'll go through implementing these methods together, but I wanted to mention a few things at a high level

* The `TaskGroupsController` is going to have these methods which correspond to the standard CRUD actions
  * We can add other ones, and we don't need them all

* We're also going to have a couple private methods

* Because there's user input for the params, we're going to want to sanitize them

* Next, we've got a method to set the task group

* At the top of the class, we're using a controller hook to indicate we want the task group to be set before any action, except for the index
* There's a few hooks around actions that you can use, and you can have as many as you like

* There's a few hooks around actions you can use, and you can have as many as you like

---

## Adding the Route


```rb [|4]
# config/routes.rb

Rails.application.routes.draw do
  resources :task_groups
end
```

Note:
* Now we gotta make the endpoints accessible
* Do that in the `routes.rb` file

* And add this `resources` call with the symbol `:task_groups`

* By saying it's a resource, Rails will automatically know how to map the CRUD actions task groups controller to an endpoint and HTTP method and URL structure
* If we have uncommon actions, we're able to manually declare them here too

<!-- TODO: show routes that are generated -->
<!-- TODO: explain create->new & update->edit -->


```rb [5]
# config/routes.rb

Rails.application.routes.draw do
  # ...
  root "task_groups#index"
end
```

Note:
* This isn't needed, but we can also use this `root` method to make the index endpoint go to the task groups index action

---

## Setting the Task Group


```rb [|4-5, 10|6-7, 10|8-10]
# app/controllers/tasks_controller.rb

def set_task_group
  @task_group = if params[:id]
                  TaskGroup.find(params[:id])
                elsif action_name == "create"
                  TaskGroup.new(task_group_params)
                else
                  TaskGroup.new
                end
end
```

Note:
* Let's first implement the setting of the task group
* This is a little complicated since we need it to go about doing this in a few ways

* First we'll check for an ID param being set
  * Generally this will be from the URL (`/task_groups/:id`)
* When we have the ID param, we'll try to find that task group
  * A cool thing about this is that if one isn't found, Rails will handle making this be a 404 response

* Next, we'll check if we're doing a create action
* If we are, we're going to make a new task group instance with the params that will be given
  * Note that this doesn't save the task group, just gives us an instance to work with

* In neither of those scenarios, we create a minimal instance
* This is mainly so we can pass it around without having `nil` errors in our template

---

## Task Group Params

Note:
* Alright, we referenced the `task_group_params` method in the last bit, so let's implement that


```rb []
# app/controllers/tasks_controller.rb

def task_group_params
  params.require(:task_group).permit(:title)
end
```

```json
{
  "task_group": {
    "title": "I am a title"
  }
}
```
<!-- .element: class="fragment" -->

```html
<input name="task_group[title]" />
```
<!-- .element: class="fragment" -->

Note:
* Rails comes with a thing called strong parameters
* It basically lets us say specific params for an endpoint will be required or can be optional, and anything that isn't specified will get ignored

* This doesn't need to be done in a separate method
  * But it helps your controller code be organized and potentially keep from repeating
* If you need to do any manipulating of params to usable values, this is a good place
* Note that we don't want to do validation of the params here, those belong in the model, not the controller

* In our case, the only param we're going to want for a task group is the name

* To help visualize this, if the params were passed in through a JSON body, it would look like this

* If you were passing it as form body params (or another way that doesn't have nested values), then it would have the nested keys be wrapped in square brackets

---

## Index Action

Note:
* Now we can focus on implementing our actual endpoints
* We'll start with the index action


```rb []
# app/controllers/tasks_controller.rb

def index
  @task_groups = TaskGroup.all
end
```

Note:
* It's pretty simple
* Just get all of the task groups, and set them to an instance variable

* If we wanted to, we could go more advanced than `all`, and add pagination, or filters, but that's not relevant at this time


```erb [|3-7|9-13|6|11]
<!-- app/views/task_groups/index.html.erb -->

<div class="d-flex justify-content-between align-items-center">
  <h1>Task Groups</h1>

  <%= link_to "New task group", new_task_group_path, class: "btn btn-outline-secondary" %>
</div>

<div class="list-group mt-5">
  <% @task_groups.each do |task_group| %>
    <%= link_to task_group.title, task_group, class: "list-group-item list-group-item-action" %>
  <% end %>
</div>
```

Note:
* On to the view template
* The file will live in a directory in the views that has the same name as the controller

* We have a sort of header
* And a list of task groups

* Rails comes with this function called `link_to` which creates an `a` tag for us
* In the first use of this, we can use a helper function `new_task_group_path` to determine what the actual path is
  * Rails is smart enough to know how to get the path for us
  * This way if that changes in our config, we don't have to update every use

* In the second use, since we're linking to a specific resource, we can just pass in that instance
  * Rails will automatically figure out what the path for that instance is, even including the ID

---

## Create Action

Note:
* Let's move on to making it possible to create task groups


```rb [|4-5, 8|6-8]
# app/controllers/task_groups_controller.rb

def create
  if @task_group.save
    redirect_to task_group_url(@task_group), notice: "Task group was successfully created."
  else
    render :new, status: :unprocessable_entity
  end
end
```

Note:
* We have a task group getting initialized with the given params via the `set_task_group` method we implemented earlier

* Calling `@task_group.save` will return true or false, depending on if the task group was valid or not
* So we're saying if it's valid and saves, then we'll redirect to the page for that task group
  * Here is also a usage of the `notice` variable we set earlier

* If it isn't valid or otherwise fails, then we'll go back to the same page, but with a different status


```erb [|5]
<!-- app/views/task_groups/new.html.erb -->

<h1>New task group</h1>

<%= render "form", task_group: @task_group %>

<div>
  <%= link_to "Back to task groups", task_groups_path %>
</div>
```

Note:
* The form that hits the `create` action, will belong to the template for the `new` action

* In our template, we can also render a partial for the task group form, passing in a bare task group variable
  * This way we can reuse the form between the new and edit pages


```erb [|3, 20|13-14|18|4-10]
<!-- app/views/task_groups/_form.html.erb -->

<%= form_with(model: task_group) do |form| %>
  <% if task_group.errors.any? %>
    <% task_group.errors.each do |error| %>
      <div class="alert alert-danger" role="alert">
        <%= error.full_message %>
      </div>
    <% end %>
  <% end %>

  <div class="mb-3">
    <%= form.label :title, class: "form-label "%>
    <%= form.text_field :title, class: "form-control" %>
  </div>

  <div>
    <%= form.submit class: "btn btn-success" %>
  </div>
<% end %>
```

Note:
* Here is the partial for the task group form
* Notice that the file name starts with an underscore, this is to signify it's a partial.

* We're using the `form_with` helper to create an HTML form that is able to submit to the create endpoint

* In the form block, we're using helpers that will create label and input tags for the title attribute

* And a final helper that will create a submit button
* A cool thing about this helper is it's able to automatically change the text if we're creating or updating an item

* It's worth pointing out that form helpers aren't necessary, they just exist to abstract your HTML
* All that really matters is your inputs have the correct name attributes

* Lastly, at the top of the form, we're making it so if the task group is invalid and fails to save, then the user can actually see why it failed

---

## Show Action

Note:
* We don't have to touch the controller code for the `show` action
  * So we can move right on to the view


```erb []
<!-- app/views/task_groups/show.html.erb -->

<div class="d-flex justify-content-between align-items-center">
  <h1><%= @task_group.title %></h1>

  <%= link_to "Edit task group", edit_task_group_path(@task_group), class: "btn btn-outline-secondary" %>
</div>
```

Note:
* The show view is pretty minimal at the moment
* Just the title, and a link to the edit page

---

## Update Action

Note:
* Now that we can create task groups, we should be able to update them


```rb [|4-5, 8|6-8]
# app/controllers/task_groups_controller.rb

def update
  if @task_group.update(task_group_params)
    redirect_to task_group_url(@task_group), notice: "Task group was successfully updated."
  else
    render :edit, status: :unprocessable_entity
  end
end
```

Note:
* For the `update` action, the `@task_group` instance variable will be an existing record
* Then we can run the `update` method on that and pass in the form params
* Like `save`, this will return `true` or `false` depending on the model's validity

* When it is valid, we'll redirect the user back to the show page

* When it's invalid, we'll keep the user on that page, and show the errors


```erb []
<!-- app/view/task_groups/edit.html.erb -->

<h1>Editing task group</h1>

<%= render "form", task_group: @task_group %>

<div class="mt-3">
  <%= link_to "Cancel", @task_group, class: "btn btn-outline-secondary" %>
</div>
```

Note:
* Because our form is in a partial, the edit view is basically the same as the new view, just switched some text
* The form helpers are dynamic enough to determine if it should send a `POST` request to the create endpoint, or a `PATCH` request to the update endpoint

---

## Destroy Action

Note:
* Now we've created a bunch of task groups, we gotta be able to get rid of them
* So let's work on the destroy action


```rb [|4|5]
# app/controllers/task_groups_controller.rb

def destroy
  @task_group.destroy!
  redirect_to task_groups_url, notice: "Task group was successfully destroyed."
end
```

Note:
* The `destroy` action is very simple

* It runs `destroy!` on the task group
* The presence of the `!` (which is pronounced "bang" in Ruby) at the end of the method name, means that this method will raise an error if it fails
  * Which is good in our case, since this can either work, or fail for a reason beyond the users control
* When that finishes, we'll take the user back to the list of task groups


```erb [|6-11]
<!-- app/views/task_groups/edit.html.erb (next to cancel button) -->

<div class="mt-3">
  <!-- ... -->

  <%= button_to(
        "Destroy this task group",
        @task_group,
        method: :delete,
        class: "btn btn-danger mt-5"
      ) %>
</div>
```
<!-- TODO: add confirmation -->

Note:
* There isn't necessarily a view for deletion, but a user still needs to be able to access the endpoint

* We can accomplish this by using the `button_to` helper to add a delete button to the edit page
* `button_to` is pretty neat, it basically creates a form with hidden inputs and a visible submit button
  * This essentially lets us link to an endpoint that isn't just a `GET` request

---

## Trying things out

<!-- TODO: get a video (show that blank names return an error) -->

Note:
* Alright, now that we have that code in place, let's see it in action
* Make sure the server is running, no need to restart it if you never stopped it
* Then go to `localhost:3000` and you should be able to do all the CRUD actions for a task group

---

## Testing Task Groups Controller

Note:
* I don't want to spend too much time getting into all of the tests
* But I do want to show you generally what they can look like


```rb [|20-23|25-35|42-49]
# test/controllers/task_groups_controller_test.rb

require "test_helper"

class TaskGroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @task_group = TaskGroup.create!(title: "Test")
  end

  test "should get index" do
    get task_groups_url
    assert_response :success
  end

  test "should get show" do
    get task_group_url(@task_group.id)
    assert_response :success
  end

  test "should get new" do
    get new_task_group_url
    assert_response :success
  end

  test "should create new task groups" do
    group_title = "I am a task group"

    assert_difference -> { TaskGroup.count }, 1 do
      post task_groups_url, params: { task_group: { title: group_title } }
    end

    created_task_group = TaskGroup.last
    assert_redirected_to task_group_url(created_task_group)
    assert_equal(group_title, created_task_group.title)
  end

  test "should get edit" do
    get edit_task_group_url(@task_group.id)
    assert_response :success
  end

  test "should update existing task groups" do
    new_title = "i have changed"

    assert_changes -> { @task_group.reload.title }, to: new_title do
      put task_group_url(@task_group), params: { task_group: { title: new_title } }
    end
    assert_redirected_to task_group_url(@task_group)
  end

  test "should delete task groups" do
    assert_difference -> { TaskGroup.count }, -1 do
      delete task_group_url(@task_group)
    end
    assert_redirected_to task_groups_url
    assert_raises(ActiveRecord::RecordNotFound) { @task_group.reload }
  end
end
```

Note:
* Looking at a test like the one for `new`, we're essentially testing that our template doesn't have errors

* Testing the `create` endpoint works is also really easy
* We can basically send a `POST` request to the `create` endpoint, and assert that doing that results in a new task group
* Going a step further, we can also assert that the created task group is what we wanted it to be

* The test for the `update` endpoint is also similar, in that we can make an assertion that the act of sending a `PATCH` request changes the actual value of the title

* Also worth mentioning, that you don't need to have the server running for these tests to run

---

## Task Groups System Tests

Note:
* We can also add system tests, which are pretty much synonymous for E2E tests
* Rails comes with Capybara, which is a Ruby library built on top of Selenium

* Bear in mind, these tests give a lot of confidence, but are really slow, since they run in an actual browser
* It's also easy to accidentally write a flaky system test
* So typically, I only write them for happy path (and not focus on edge cases), or really critical functionality


```rb [|23-32]
# test/system/task_groups_test.rb

require "application_system_test_case"

class TaskGroupsTest < ApplicationSystemTestCase
  setup do
    @task_group = TaskGroup.create!(title: "Test Group")
  end

  test "visiting the index" do
    visit task_groups_url
    assert_selector "h1", text: "Task Groups"
    assert_link @task_group.title
  end

  test "showing a task group" do
    visit task_groups_url
    assert_no_selector "h1", text: @task_group.title
    click_link @task_group.title
    assert_selector "h1", text: @task_group.title
  end

  test "creating a task group" do
    visit new_task_group_url

    title = "A new task group"
    fill_in "Title", with: title
    click_button "Create Task group"

    assert_text "Task group was successfully created."
    assert_selector "h1", text: title
  end

  test "editing a task group" do
    visit edit_task_group_url(@task_group)

    original_title = @task_group.title
    new_title = "the new title"
    fill_in "Title", with: new_title
    click_button "Update Task group"

    assert_text "Task group was successfully updated."
    assert_selector "h1", text: new_title

    visit task_groups_url
    assert_no_text original_title
    assert_link new_title
  end

  test "deleting a task group" do
    visit edit_task_group_url(@task_group)
    click_button "Destroy this task group"

    assert_text "Task group was successfully destroyed."
    assert_no_text @task_group.title
  end
end
```

Note:
* Anyway, this is what some system tests for task groups could look like

* Let's take a quick look at the test for creation
* We load up the page, fill out the form, and add assertions that (from the user perspective) a task group was created

---

## Running System Tests

```sh
rails test:system
# or
rails test path/to/test.rb
```

<!-- TODO: drop in a video of them running -->

Note:
* To run the system tests, you need to run either `rails test:system` or `rails test` specifying the path to the tests

* Like the other tests, you don't need to have the Rails server running in the background to run the system tests
* You can also make these tests run headlessly as well, which makes running them less annoying

---

# Generate Task Resource

Note:
* Alright, let's create the actual task resource
* I'm going to go faster for these things, since it's fairly similar


```sh []
rails g model Task \
  title:string \
  completed:boolean \
  due_at:datetime \
  task_group:references \
  --no-fixture
```

Note:
* We're going to have some more fields for tasks
* Notice how this command has `task_group:references`
  * Rails uses this as a shorthand to create a column `task_group_id`, setup a foreign key constraint, and to create an index on it.

---

## Task Migration Updates


```rb [|6-7]
# create task migration

class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :title, null: false
      t.boolean :completed, null: false, default: false
      t.datetime :due_at
      t.references :task_group, null: false, foreign_key: true

      t.timestamps
    end
  end
end
```

Note:
* Like before, we're going to modify the migration to add some database constraints

* We're going to require `title` and `completed`
* In the case of completed however, we're also saying if it's not given, just default to `false`
* While `null` and `false` are pretty similar in Ruby, there's some edge cases we want to avoid, so it's better to have a default when working with booleans


```sh
rails db:migrate
```

Note:
* Then run the migration

---

## Task Model Validation


```rb [|6|4]
# app/models/task.rb

class Task < ApplicationRecord
  belongs_to :task_group

  validates :title, presence: true
end
```

Note:
* Here's the task model

* Like the task group, we're validating we have a title
* Because `completed` has a default value, we don't need to bother specifying that it's required in the model

* We can also specify that a task belongs to a task group
* This'll let us get the task group for a task by doing `task.task_group` for example
  * Keep in mind that this will result in a database call per task instance, however accessing it multiple times will used a cached version

---

## Add Relation to Task Group

Note:
* We added a `belongs_to` relation on the task to the task group, but we can also add the inverse


```rb [4]
# app/models/task_group.rb

class TaskGroup < ApplicationRecord
  has_many :tasks, dependent: :destroy

  validates :title, presence: true
end
```

Note:
* On the `TaskGroup` model, we can say it has many tasks
* So when we're working with a task group, we can get all the tasks that belong to it by doing `task_group.tasks`

* Additionally, we're specifying when a task group is deleted we can also delete the tasks

---

## Testing Task Model

Note:
* Now let's get some tests for the task model


```rb [|6-9]
# test/models/task_test.rb

require "test_helper"

class TaskTest < ActiveSupport::TestCase
  setup do
    task_group = TaskGroup.new(title: "test")
    @task = Task.new(title: "Do the thing", task_group: task_group)
  end

  test "is valid" do
    assert @task.valid?
  end

  test "requires a title" do
    @task.title = nil
    assert_not @task.valid?
    assert_includes @task.errors, :title
  end
end
```

Note:
* This is nearly identical to the task group model tests

* The main difference is in the setup, we're making a new task group that the task can belong to

---

# Creating Tasks Controller <!-- .element: class="r-fit-text" -->

Note:
* We need a controller for tasks


```rb [|4-5|30-42|]
# app/controllers/tasks_controller.rb

class TasksController < ApplicationController
  before_action :set_task_group
  before_action :set_task

  def create
    if @task.save
      redirect_to task_group_url(@task_group), notice: "Task was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @task.update(task_params)
      redirect_to task_group_url(@task_group), notice: "Task was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy!
    redirect_to task_group_url(@task_group), notice: "Task was successfully destroyed."
  end

  private

  def set_task_group
    @task_group = TaskGroup.find(params[:task_group_id])
  end

  def set_task
    @task = if params[:id]
              @task_group.tasks.find(params[:id])
            elsif action_name == "create"
              @task_group.tasks.new(task_params)
            else
              @task_group.tasks.new
            end
  end

  def task_params
    params.require(:task).permit(:title, :due_at, :completed)
  end
end
```

Note:
* The tasks controller is nearly the same as the task groups controller, though there are a couple things to point out

* First, we have two before actions
* One to set the task group, and another to set the task

* Further down at the implementation of these, you'll see that we have a param for the task group ID
  * Based on how we're going to route this controller, this param will always be present
* When we're setting the task, we're also able to have it scoped to that task group

* The second thing is that we're not going defining an index action
* The tasks will be listed on the show page for task groups instead of on their own page

---

## Task Controller Routing

Note:
* Moving on to the routing for the tasks controller


```rb [4-6]
# config/routes.rb

Rails.application.routes.draw do
  resources :task_groups do
    resources :tasks, except: %i[index show]
  end

  # ...
end
```

```text
/task_groups/:task_group_id/tasks/:id
```
<!-- .element: class="fragment" -->

Note:
* Tasks belong to task groups, and we can express this through our routing
* Modify the the original `resources` call to take a block, and inside of that block, add a `resources` call for tasks

* Like I said, we're not going to have an index or a show action, so we can keep add this `except` option to exclude those
* This isn't technically necessary, but without it the pages will exist but result in an error if visited

* I'm also going to draw attention to this `%i` array
* This is just syntactic sugar for saying it's an array of symbols

* Anyway, this is what our URL structure will look like for tasks

---

## Change Show Task Group View

Note:
* We've got the controller implemented, so let's power through creating the views


```erb []
<!-- app/views/task_groups/show.html.erb -->

<div class="mt-5">
  <div class="mb-3">
    <%= link_to "New task", new_task_group_task_path(@task_group), class: "btn btn-primary" %>
  </div>
</div>
```

Note:
* On the show task groups page, we're going to add a link to the new task page

---

## New Task Page


```erb [|5]
<!-- app/views/tasks/new.html.erb -->

<h1>New task</h1>

<%= render "form", task_group: @task_group, task: @task %>

<div>
  <%= link_to "Back to tasks", task_group_path(@task_group) %>
</div>
```

Note:
* The new task page will look like this
* Basically just like the new task group page, and it renders a form partial

* Notice that we're passing in both the task group and task


```erb [|3|17-20]
<!-- app/views/tasks/_form.html.erb -->

<%= form_with(model: [task_group, task]) do |form| %>
  <% if task.errors.any? %>
    <% task.errors.each do |error| %>
      <div class="alert alert-danger" role="alert">
        <%= error.full_message %>
      </div>
    <% end %>
  <% end %>

  <div class="mb-3">
    <%= form.label :title, class: "form-label "%>
    <%= form.text_field :title, class: "form-control" %>
  </div>

  <div class="mb-3">
    <%= form.label :due_at, class: "form-label" %>
    <%= form.datetime_field :due_at, class: "form-control" %>
  </div>

  <div>
    <%= form.submit class: "btn btn-success" %>
  </div>
<% end %>
```

Note:

* The form itself is also pretty similar, the only things different are

* First, we're using an array of models
  * This is so Rails is able to figure out the URL the form submits to

* Second, we have another field, that's a datetime input

---

## Showing Tasks in Task Group View

Note:
* Moving on to displaying the tasks


```erb [8-10]
<!-- app/views/task_groups/show.html.erb -->

<div class="mt-5">
  <div class="mb-3">
    <%= link_to "New task", new_task_group_task_path(@task_group), class: "btn btn-primary" %>
  </div>

  <div class="list-group">
    <%= render @task_group.tasks, task_group: @task_group %>
  </div>
</div>
```

Note:
* Back in the task group show page, we can render a list of tasks
* Passing an ActiveRecord collection to the `render `funciton will make it automatically list over them and render the partial for that resource


```erb [|3-8, 38|6|9-15|18-34|36]
<!-- app/views/tasks/_task.html.erb -->

<%= tag.div(
  class: class_names(
    "list-group-item d-flex justify-content-between align-items-center",
    "list-group-item-success": task.completed
  )
) do %>
  <div>
    <h2><%= task.title %></h2>

    <% if task.due_at %>
      <p class="text-muted"><%= task.due_at %></p>
    <% end %>
  </div>

  <div class="d-flex">
    <% if task.completed %>
      <%= button_to(
            "Incomplete",
            [task_group, task],
            method: :patch,
            class: "btn btn-outline-secondary",
            params: { task: { completed: false } }
          ) %>
    <% else %>
      <%= button_to(
            "Complete",
            [task_group, task],
            method: :patch,
            class: "btn btn-outline-success",
            params: { task: { completed: true } }
          ) %>
    <% end %>

    <%= link_to "Edit", edit_task_group_task_path(task_group, task), class: "btn btn-link" %>
  </div>
<% end %>
```

Note:
* In our case, the resource is a task, so we need to make a task partial
* This view is a little complicated, so we can break it down a bit

* Starting at the top, we're using a helper to create the div instead of normal HTML
* This is a little bit just preference, but I like to do this if I'm going to use a Rails helper for the value of an attribute
  * Which is what we're doing with the `class_names` helper

* The `class_names` helper is a function that let's us conditionally add classes in a clean way
* The key is the class that will get added, and the value is either truthy if we want it, or falsy if we don't

* As we go down it gets a little simpler
* We're outputting the title
* If there's a due date, we're also adding that to the page
* We could specify a format for the due date, but the default will do for now

* Further down, we're conditionally adding a button to either set a task as complete or incomplete
* This could maybe be a little more DRY, but it's fine for now
* We're using `button_to` which, like I mentioned earlier, will create a form on the page
  * This time however, we're adding specific params that will get turned into hidden input elements
  * We're also specifying to use a `PATCH` request so it uses the correct action
  <!-- TODO: ensure the method is needed -->
* Because Turbo is in the project, the UX is actually similar to if this were done with JavaScript rather than a page refresh

* Lastly, we're adding a button to link to the edit page

---

## Edit Task Page


```erb []
<!-- app/views/tasks/edit.html.erb -->

<h1>Editing task</h1>

<%= render "form", task_group: @task_group, task: @task %>

<div class="mt-3">
  <%= link_to "Cancel", @task_group, class: "btn btn-outline-secondary" %>

  <%= button_to(
        "Destroy this task",
        [@task_group, @task],
        method: :delete,
        class: "btn btn-danger mt-5"
      ) %>
</div>
```

Note:
* Lastly, let's add the edit page
* It's basically the same as the edit page for task groups

---

## Testing the Tasks Controller

Note:
* Here's the tests for the tasks controller


```rb []
# tests/controllers/tasks_controller_test.rb

require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @task_group = TaskGroup.create!(title: "Test group")
    @task = @task_group.tasks.create!(title: "I am a task")
  end

  test "should get new" do
    get new_task_group_task_url(@task_group)
    assert_response :success
  end

  test "should create new tasks" do
    freeze_time
    task_params = {
      title: "Do the thing",
      due_at: 2.days.from_now
    }

    assert_difference -> { @task_group.tasks.count }, 1 do
      post task_group_tasks_url(@task_group), params: { task: task_params }
    end
    assert_redirected_to task_group_url(@task_group)

    created_task = @task_group.tasks.last
    assert_equal(task_params[:title], created_task.title)
    assert_equal(task_params[:due_at], created_task.due_at)
  end

  test "should get edit" do
    get edit_task_group_task_url(@task_group, @task)
    assert_response :success
  end

  test "should update existing tasks" do
    assert_changes -> { @task.reload.completed }, to: true do
      patch task_group_task_url(@task_group, @task), params: { task: { completed: true } }
    end
    assert_redirected_to task_group_url(@task_group)
  end

  test "should destroy tasks" do
    assert_difference -> { @task_group.tasks.count }, -1 do
      delete task_group_task_url(@task_group, @task)
    end
    assert_redirected_to task_group_url(@task_group)
    assert_raises(ActiveRecord::RecordNotFound) { @task.reload }
  end
end
```

Note:
* This is nearly identical to the task groups controller tests, so I'm not going to go over them

---

## Tasks System Tests

Note:
* Let's add the system tests


```rb []
# tests/system/tasks_test.rb

require "application_system_test_case"

class TasksTest < ApplicationSystemTestCase
  setup do
    @task_group = TaskGroup.create!(title: "Test Group")
    @task = @task_group.tasks.create!(title: "Test Task")
  end

  test "listing tasks" do
    visit task_group_url(@task_group)
    assert_selector "h2", text: @task.title
  end

  test "creating a task" do
    title = "hello world"
    due_date = 2.days.from_now
    visit task_group_url(@task_group)

    assert_no_text title
    assert_no_text due_date
    click_link "New task"

    fill_in "Title", with: title
    fill_in "Due at", with: due_date
    click_button "Create Task"

    assert_text "Task was successfully created"
    assert_selector "h2", text: title
    assert_text due_date.strftime("%Y-%m-%d %H:%M:00 %Z")
  end

  test "completing a task" do
    visit task_group_url(@task_group)

    assert_no_text "Incomplete"

    click_button "Complete"

    assert_text "Task was successfully updated."
    assert_text "Incomplete"
    assert_no_text "Complete"
  end

  test "incompleting a task" do
    @task.update!(completed: true)
    visit task_group_url(@task_group)

    assert_no_text "Complete"

    click_button "Incomplete"

    assert_text "Task was successfully updated."
    assert_text "Complete"
    assert_no_text "Incomplete"
  end

  test "editing a task" do
    original_title = @task.title
    new_title = "i have a new title"

    visit task_group_url(@task_group)
    assert_no_text new_title

    click_link "Edit"
    fill_in "Title", with: new_title
    click_button "Update Task"

    assert_text "Task was successfully updated."
    assert_selector "h2", text: new_title
    assert_no_text original_title
  end

  test "deleting a task" do
    visit edit_task_group_task_url(@task_group, @task)

    click_button "Destroy this task"
    assert_text "Task was successfully destroyed."
    assert_no_text @task.title
  end
end
```

Note:
* Again, these are nearly the same, so I'm not going to go into detail for these, just want to show they exist

---

# Model Scopes

Note:
* One of the cool things about ActiveRecord is it's composability
* It doesn't actually do a query until you output a value or turn it into an array
* This makes it so you can just keep on chaining ActiveRecord methods, and when it's ready it will build a query that is efficient and removes any redundancies it's aware of

* It also lets you create what Rails calls "scopes" to abstract specific queries
* These are essentially class methods that you can add that are slices of a query

---

## Complete and Incomplete Scopes

Note:
* To demonstrate this, let's add scopes to get completed or incomplete tasks


```rb [6-7]
# app/models/task.rb

class Task < ApplicationRecord
  # ...

  scope :completed, -> { where(completed: true) }
  scope :incomplete, -> { where(completed: false) }
end
```

Note:
* In the `Task` model, at the class level, we can run the `scope` method
* It takes a name, then a lambda that returns the ActiveRecord queries we want
  * You're able to do Ruby logic in here if you want, and you can also make the lambda have parameters

* This is a pretty simple example, but it lets our query read more like a sentence, and if we ever change how we define what a completed or incomplete task actually is, then we only have one spot to update

<!-- TODO: Testing Task Scopes -->

---

## Using Our Scope

Note:
* Now let's actually use the scopes we created


```erb [8-14]
<!-- app/views/task_groups/index.html.erb -->

<div class="list-group mt-5">
  <% @task_groups.each do |task_group| %>
    <%= link_to task_group, class: "list-group-item list-group-item-action" do %>
      <%= task_group.title %>

      <span class="badge bg-warning rounded-pill">
        <%= task_group.tasks.incomplete.count %> incomplete
      </span>

      <span class="badge bg-success rounded-pill">
        <%= task_group.tasks.completed.count %> complete
      </span>
    <% end %>
  <% end %>
</div>
```

Note:
* Back on the task groups index page, we can add `tasks.incomplete.count` and `tasks.completed.count`
* Pretty slick

---

# Seed Data

Note:
* Seed data is essentially placeholder data you can use during development
* It lets you tear down and setup useful data easily and consistently
  * As opposed to manually entering a bunch of data

---

## Adding Seeds

Note:
* Rails comes with a pattern for setting up seed data


```rb []
# db/seeds.rb

2.times do |task_group_number|
  task_group = TaskGroup.create!(title: "Task Group #{task_group_number}")

  6.times do |task_number|
    due_date = task_number.even? ? task_number.months.from_now : nil
    completed = (task_number % 3).zero?

    task_group.tasks.create!(
      title: "Task #{task_group_number}x#{task_number}",
      due_at: due_date,
      completed: completed
    )
  end
end
```

Note:
* Basically, it's just a script that knows about some of your Rails code
* So in this case, I'm using a loop to create two task groups
* In each task group, I'm creating 6 tasks
* To get a bit of variance
  * I'm making every other task have a due date
  * Making every third task be complete


```sh
rails db:seed

# or reset with
rails db:schema:load db:seed
```

Note:
* We can run this with the `rails db:seed` command
* If you run this command multiple times, it will just add more data
  * Which can be problematic if you don't handle uniqueness constraints
* So if you want to wipe your database and then seed, you can run `rails db:schema:load db:seed`

* There's also libraries that can help you organize and break up seeds
* If you have a lot of models, you probably don't want them all in one file

<!-- TODO: find out what that one library is -->

---

# High Level Territory

Note:
* There's a couple additions that we could make to this codebase
* For the sake of time, and to not keep slamming you with information, I'm going to just talk about these at a high level

---

## Factory Bot

Note:
* The first thing I want to mention is a gem called Factory Bot, it's used to create data for your tests
* It's a lot more sustainable than creating all the data for a test manually
* And in my opinion it's significantly easier to reason about than fixtures
* It can also give a bit more confidence in your tests than fixtures, since it runs model callbacks (which fixtures do not)

<!-- TODO: add link to it -->
<!-- use factory_bot_rails -->

---

## Example Use

Note:
* Before I show how they're implemented, let's take a look at what it looks like to use them


```rb []
setup do
  task_group = TaskGroup.create!(title: 'i am a group')
  @task = Task.create!(title: 'i am a task', task_group: task_group)
end
```

```rb []
setup do
  @task = create(:task)
end
```
<!-- .element: class="fragment" -->

```rb []
setup do
  @task = create(:task, title: 'i am a task')
end
```
<!-- .element: class="fragment" -->

Note:
* Think back to our tests for the task model
* We were creating a task group, but it wasn't really needed
* And we also had to give values to all the attributes even though we don't really care about their values

* With Factory Bot we can be more minimal with this creation, and basically just say "create me a task", and it handles everything
* But if we did want to specify a title for the task, we're able to do just pass one in

---

# Factory Definition

Note:
* This isn't completely magic though, because we still need to actually define what will go in those records


```rb []
FactoryBot.define do
  factory :task_group do
    sequence(:title) { |n| "Task Group #{n}" }
  end

  factory :task do
    sequence(:title) { |n| "Task #{n}" }
    task_group
  end
end
```

Note:
* Here is what a minimal version of our factories could look like
* We've got a factory for a task group, which will all have unique, incremental titles
* Then we do the same thing for the task factory, but we also say it references a task group, which will create one for us if one isn't given
* Due to the name of the factories, Factory Bot is able to map these to their respective model classes

---

# Authorization and Authentication <!-- .element: class="r-fit-text" -->

Note:
* The last thing I want to get into a bit more detail about is how to do authentication and authorization
* Rails doesn't actually have a built in way to do this, but there's a few popular gems to avoid rolling this yourself
  * Which beyond speed of implementing, you're better off not doing security yourself

---

## Devise

Note:
* Devise is a gem to manage authentication of users
* When you add it, you can either create a user model or attach it to an existing one
* Out of the box
  * You get the ability to authenticate controllers and your controllers are aware of the current user
  * Basic templates to let users manage their accounts
* There's a number of plugins for it, even for adding OAuth and API token support

---

## Pundit

Note:
* For authorization, there's a few popular libraries, but I recommend Pundit
* Pundit has two sides that it can help with
* The first is policies, which are in charge of permitting access to an endpoint
* The second is scopes, which are for filtering sets of data to only data the user has access to

---

## Pundit Policies

Note:
* Let's take a look a policy in Pundit

```rb []
class TaskGroupsController < ApplicationController
  def show
    @task_group = TaskGroup.find(params[:id])
    authorize @task_group
  end
end
```

```rb []
class TaskGroupPolicy < ApplicationPolicy
  def show?
    @task_group.user == current_user
  end
end
```

Note:
* In this example, pretend like task groups belong to users
* When we run the `authorize` method in the `show` action of the `TaskGroupController`, it will go to the `TaskGroupPolicy` and run the `show?` method
* The method in the policy will return either `true` or `false` depending if the user has access

---

## Pundit Scopes

Note:
* Now let's see what a Pundit scope might look like

```rb []
class TaskGroupsController < ApplicationController
  def index
    @task_groups = policy_scope(TaskGroup)
  end
end
```

```rb []
class TaskGroupPolicy < ApplicationPolicy
  # ...

  # TODO: double check this is correct
  class Scope
    def resolve
      scope.where(user: current_user)
    end
  end
end
```

Note:
* In the `resolve` method, `scope` is whatever we passed to `policy_scope` in the controller
* So in our case, we start with all task groups, then add a where clause to get the ones just for that user
* Pundit works out which scope to use by the name of the model we give it

---

## Keep Learning

https://guides.rubyonrails.org

Note:
* If you want to keep learning about Rails, the Rails guides are a really good resource that go into depth without being straight API docs

---

## Name Dropping Gems

* Rubocop (linting)
* RSpec (testing framework)
* Ransack (model filtering)
* Kaminari (pagination)
* Strong Migrations (catch unsafe migrations)
* Pry (debug tool)

---

# We Made It

<!-- TODO: get a link to the repo -->
<!-- TODO: link to long form article article -->
<!-- TODO: confetti gif -->
<!-- TODO: get lines of code added and removed since init -->

Note:
* We've made it to the end!
* Here's a link to the code if you want to explore it in it's full context

# Thank You!

<!-- TODO: add rubocop to make sure not doing anything bad apart from frozen_string_literal missing -->
<!-- TODO: ensure all TODO items are resolved -->
<!-- TODO: ensure all code blocks have line numbers -->
<!-- TODO: need a back button from single group to all groups -->
<!-- TODO: ensure all html blocks are actually erb -->
<!-- TODO: ensure all comments are resolved or todo -->
<!-- TODO: ensure all code has line numbers -->
<!-- TODO: ensure all solo codeblocks with scrolls have r-stretch class -->
