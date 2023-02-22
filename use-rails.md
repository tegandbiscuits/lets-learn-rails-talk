<!-- * Intro
  * Long form article exists which will be more accessible
* Audience
  * Devs who want to build a backend for something, but don't want to live in that world
  * People who don't want to spend a lot of time on decision making / establishing patterns
    * People who want to hit the ground running -->

# You Should Use Rails

Note:
* There's an idea that Rails is a dying framework.
* It's less hot than it used to be, but it is very much alive, and is still a very useful framework and ecosystem.
* Both for MPA and API based stuff.

---

## Loads Out of the Box

Note:
* Rails can do a lot of things right out of the box.
<!-- TODO: need to list things -->

---

## All The Patterns

Note:
* Convention over code philosophy driven so you don't need to think about stuff that's not unique to you, and a lot of patterns are baked in.
* But also doesn't restrict you if you need to break convention.
* Also makes it easier to keep codebase organized and reason about, which helps as it or your team grows.
* Easy to return to an old codebase, or for a new person to get up to speed.

---

## Great Tooling

Note:
* Tooling is matured, so things are battle tested, and it's easy to find off the shelf libraries.
* Has a very big testing focus in the community.
* It's also easy to debug code.
* Partly because Ruby is an easy language to test.

---

## Hit The Ground Running

Note:
* Because of these, you can keep from reinventing the wheel a lot.
* Both in libraries, and with how Ruby works, also in your own code (metaprogramming).
* Easy to hit the ground running, and deliver things fast.

---

## Useful For Many

Note:
* Pretty much any team or project size can benefit from these
* Move fast, keep code DRY, easy to not step on toes
* It's also easy to pick up, so if you're an app or frontend dev working on something that needs an API, you can go pretty far before needing a dedicated backend person (though I wouldn't recommend that for important things)
* Big users include Shopify and Github

---

## Ruby Is Great

Note:
* Ruby is also a really fun language to work with, so that in itself is a benefit.
* It was literally made to make developers happy.

---

## The Community is Fantastic

Note:
* The community is large and active.
* RailsConf and RubyConf are both large conventions to meet Rails/Ruby devs.
* The community is a very nice and accepting of all people.
* There's a concept of "Matz  [the creator of ruby] is nice and so we are nice."

---

# Let's Build Something

A todo app <!-- .element: class="fragment" -->

<!-- TODO: Ensure this is all done -->

* Task groups <!-- .element: class="fragment" -->
* Logins + basic user management <!-- .element: class="fragment" -->
* Permissioning <!-- .element: class="fragment" -->
* Tests <!-- .element: class="fragment" -->
* (MPA with ERB for ease of demonstration) <!-- .element: class="fragment" -->

Note:
* Maybe (hopefully) you're a bit interested in Rails, so now I'm going to demonstrate some of the things reasons to use it by walking through building a web app.

---

# Ruby Primer

Note:
* If you're looking at Rails for the first time, there's a pretty good chance you're not super familiar with Ruby.
* It's fairly intuitive by reading it, but here's a few things that are worth pointing out.
<!-- * Ruby is used for things outside of rails, but ruby developers and at (at some point) rails developers is a pretty big overlap. -->

---

## Packages

Packages are called gems.
They can be declared in a `Gemfile`.
Gemfiles are interacted with using a tool called Bundler.

---

## Some Things Can Be Implied/Omitted

Note:
* A big thing is that might throw off someone is the amount of syntax that can be implied.


### Return Statements

```rb
def greet
  return "hello world"
end
```

```rb
def greet
  "hello world"
end
```


### Parenthesis

```rb
def greet
  "hello world"
end
greet
#=> "hello world"

def foo(name)
  "hello #{name}"
end
greet "friends"
#=> "hello friends"
```

Note:
* Parenthesis are optional
* Can be confusing (so don't do this) if multiple functions on one line take arguments
  * Not clear which argument belongs to which function


### Curly Braces For Hashs

_Only when the last argument of a function_

```rb
def do_something(name, options)
  # ...
end

do_something("foo", { option_a: "meow", option_b: "woof" })
# same as
do_something("foo", option_a: "meow", option_b: "woof")
```

Note:
* A hash is Ruby speak for an object in JavaScript.

<!-- should there be something for keyword arguments? -->

---

## Functions Can Run Pretty Much Anywhere

_but still have contexts they are scoped to_

```rb
class Foo
	puts "hello world"
end
#"hello world"
#=> nil
```

Note:
* Functions and mthods can be ran nearly everywhere.
* They are still scoped to contexts, but the contexts they can be used in are pretty broad
* In this case, declaring the class `Foo` will log `"hello world"`.
  * This only happens when this code is evaluated, not every time an instance of `Foo` is created (so typically once).
* You'll see this a lot when including a module that adds behavior to a class

---

## Symbols

```rb
:i_am_a_symbol
```

```rb
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
* A symbol is basically a word that has a colon in front of it that can be passed around as a value.
* It's like a spicy string
* Typically, these are not visible to an end user
  * Example: a user inputs a string instead of a symbol
  * Though what an end user sees/inputs can be transformed from/to a symbol.
* Symbols are useful for when you want to signify that an argument more specific than an arbitrary string
* The main technical difference is that every use of a specific symbol occupies the same place in memory
  * Creating a load of symbols `:loud` will use less memory than creating a bunch of strings `"loud"`
  * This has never been useful knowledge

---

## Base setup

* Ruby (`rbenv` or `rvm`)
* Rails CLI (`gem install rails`)

Note:
* You need Ruby on your system.
  * Strongly recommend either `rbenv` or `rvm`.
* Once you have those installed, select a version of Ruby to use.
* I'm going to use Ruby 3.

* Get the Rails CLI by running `gem install rails`.
* At this time, the current version is Rails 7.0.

---

## Create The Project

```sh
rails new planner --database postgresql
```

<!-- for some reason stylesheets tried to be pulled in but failed, need to resolve -->
<!-- for now just deleted application.css and removed the import -->

Note:
* Now we can generate a rails project.
* Running `rails new` will create a project, and we're going to name it `planner`

* Then we're going to specify Postgres as the database for ActiveRecord to use.
* There's a number of options you can use for this, but Postgres is usually the best choice.
* You can always change it later
<!-- can you add multiple types of databases at once now? -->

<!--
* As much as I love Rails, the core Rails team isn't great at having good opinions on JavaScript
* If you're not going to use JavaScript much then the defaults are fine, or even helpful
* However larger projects would be better of just using a vanilla Webpack or ESBuild setup
* So to keep things clear, we're just going to get rid of the asset pipeline and out of the box JS stuff
* I will point out that not super uncommon for Rails libraries that have a frontend aspect to them to require the asset pipeline
* However you can always add it in later (the same applies for any `rails new` option)
-->

* Now we've ran that it'll create a `planner` directory with a bunch of files and run `bundle install` to install our gems.

---

## A Note About JavaScript + Rails

---

## Running Things

```sh[1|2-3|4]
cd planner
# with postgres (or whichever database) running
rails db:create # creates planner_development and planner_test
rails serve
```

```sh
rails test
```
<!-- .element: class="fragment" -->

Note:
* Go to the directory of the project
* Use `rails db:create` to create the databases for our dev environments
* Then run `rails serve`
  * You'll have to restart sometimes, but generally can just leave this running
* You should be able to go to `localhost:3000` and see the hello world screen
<!-- collect a screenshot -->

* You can also run the tests
* There aren't any tests, but you should at least see there aren't errors

---

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

Note:
* For mailers to work, they need to be plugged into an SMTP server
  * For local development, Mailhog is a really useful tool
* Models are usually database backed, but don't need to be
* Your views can create different output, such as HTML, JSON, even CSVs or plaintext
* There's a bunch of different templating languages you can use, but the default, ERB, is good and simple

---

# Generate Task Group Model

Note:
* Now we've got some things initialized, let's make some interesting things.
* The first thing we're going to do is create the model for task groups.
* The model is going to be pretty simple right now, we're only going to have a name.

---

```sh [|1|2|3]
rails generate model TaskGroup \
  title:string \
  --skip-fixture
```

<!-- show what this generates -->

Note:
* Rails is handy and comes with a bunch of generators to spit out boilerplate code.

* We want to run the generate task, specifying we want a model we call `TaskGroup`.

* We can also use this syntax of `property:type` to spit out more code for us
* So here we have one property called `name` that will be a `string`
* There's a bunch of types you can use
  * However you're a little limited by what database you use

* I also added the flag `--skip-fixture` because we're not going to want fixtures.
* A fixture is a YAML file that gets thrown into the database during each test to reduce test setup code
* They're good in theory, but in practice get messy really fast
* Later on I will be showing a better alternative

* It's worth pointing out that the generators are just for convenience, you don't _need_ to use them.

* After running this command a few files will be created.
* A database migration to create the table
* The ruby class for the model
* A test file for the class

---

## Requiring Title in the DB

```rb [|5]
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
* There's still a little bit of manual work to do.

* First we're going to open the migration and say the `title` column will be required
* So the newly created migration file will look like this

---

## Requiring Title in the Ruby Class

```rb [|2]
class TaskGroup < ApplicationRecord
  validates :name, presence: true
end
```

Note:
* We're also going to indicate that requirement in the Ruby class
* We do this by running the `validates` method at the class level, which will make Rails aware that `title` is required

---

## Why Require Twice?

* Rails Validation
  * Avoids DB requests that will fail
  * Adds methods to `TaskGroup` instances that are useful
  * Also checks for empty strings
* Database Validation
  * Prevents manual updates from not having a name
  * Certain methods in Rails can skip validation
  * Get an idea of requirements just by looking at the data

Note:
* There's a few reasons why we're saying name is required in two places

* Some of the methods that validates adds will also make it easier to debug
* Just jump in a rails console and see see if something is valid and why it's not

---

```sh
rails db:migrate
```

Note:
* With Postgres running, we can now run the migration

---

## Testing Task Group Model

```rb [|4-7|8-10|12-16]
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

Note:
* Let's throw together some quick test.
* I'm not going to get too deep into testing since that's a big subject.
* This is just for the model, so we'll crack open `task_group_test.rb`, and get to work.

* First, we're going to build a task group, and set it to the instance variable `@task_group`

* Next, we'll have a test to make sure it actually is valid as a control.

* And we'll add our test that when the name is `nil` the task group is invalid.

* Also to be sure to mention, the database is reset between each test
  * So we don't have to worry about leaky tests


```sh
rails test
# show output
```

Note:
* You can run these with `rails test`.
* You can also specify which test file to run if you want.

---

## Making Things Pretty

```html
<!-- app/views/layouts/application.html.erb (inside `head` element) -->

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" >
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
```

Note:
* To help style things, I'm going to add Bootstrap to the project.
* To keep things simple for this demo, I'm going to just link to a CDN build
* Rails has a file `application.html.erb` which is a layout template
* It will automatically surround our other pages
* It is possible to override this behavior or have multiple layout templates
* So we can add these tags to the `head` of that file
* It can be added by adding this to the `head` tag in `application.html.erb`.

---

## Notice Container

```erb
<!-- app/views/layouts/application.html.erb (inside `body` element) -->

<div class="container">
  <% if notice %>
    <div class="alert alert-success" role="alert">
      <%= notice %>
    </div>
  <% end %>

  <%= yield %>
</div>
```

Note:
* `notice` is a variable that can be set as a positive flash message

<!-- TODO: after this slide is a good place to remove turbolinks hello world cruft -->

---

# Creating a Controller

Note:
* We've got this model, but now we need to actually do something with it.
* That will be the controller's job.
* We could use a generator, but to we're going to do this manually to explain things along the way

<!-- should I give a sentance for what a controller is? -->


```rb
# app/controllers/task_groups_controller.rb

class TaskGroupsController < ApplicationController
end
```

Note:
* Create a file `app/controllers/task_groups_controller.rb`, and corresponding class.

* Note that `TaskGroups` is plural
* Controllers should have plural names, and models are singular
* This is convention, and you'll want to follow convention because it makes your life easier, and in a lot of ways helps rails work it's magic
* Similarly, you want files to have snake case versions of the class that's in them
  * Makes the autoloader work

---

## Scaffolding Controller Methods

```rb [|10-12|22|24|4]
# app/controllers/task_groups_controller.rb

class TaskGroupsController < ApplicationController
  before_action :set_task_group, except: [:index]

  def index; end

  def show; end

  def new; end

  def create; end

  def edit; end

  def update; end

  def destroy; end

  private

  def task_group_params; end

  def set_task_group; end
end
```

Note:
* The `TaskGroupsController` is going to have these methods which correspond to endpoints / actions.
* We'll go through implementing them together, but I wanted to mention a few things at a high level.
* This might look like it's going to get wild, but actually it'll be pretty simple
  * A few methods will even remain empty

* You might've noticed, we have methods that sound pretty similar, like `new`/`create` or `edit`/`update`.
* This is because we're going to have pages like `/task_groups/new`, which will be a `GET` action to show the page (`new`).
* Then the form on that page will send a `POST` request to `/task_groups`, which hits the `create` action, which also does most of the actual work.
* If you're building just an API, then you don't need to have these similar methods
* Or if you don't need all the actions or have two views actions in one, then you don't need to have them

* We're also going to have a couple private methods to keep our code from repeating itself.

* Rails has a way to sanitize params / user input which we will want to use.
* Because we're going to have the same params for both creating and updating, we can just use a method for that.

* Next, we've got a method to set the task group.
* At the top of the class, we're indicating that it will be before every action except for the index action.
* Every action but the index is going to have a specific task group, so we can really simplify our methods with this abstraction.
* In fact, because of this, we won't even need any code in the methods for `new` or `edit`.

* There's a few hooks around actions you can use, and you can have as many as you like

---

## Adding the route

```rb [|4]
# config/routes.rb

Rails.application.routes.draw do
  resources :task_groups
end
```

```rb
root "task_groups#index"
```
<!-- .element: class="fragment" -->

* Now we gotta make the endpoints accessible
* Do that in the `routes.rb` file
* An add this `resource` call with the symbol `:task_groups`

* By saying it's a resource, rails will automatically know how to map each action in our task groups controller to an endpoint and HTTP method
  * Convention
* You can also omit specific things from the resource call
  * e.x. if you don't have a show page
* Though we have the control to override this behavior or do something else if we need.

* We can also use this root method to redirect the index page to the taskg groups index action

---

## Setting the task group

```rb
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
* Let's first implement the setting of the task group.

* If the route has an ID for the task group, then we'll use that task group, otherwise we'll create a new one
* Note that this is just a new instance of a task group
  * It's not saved until we tell it to be saved

* It's worth pointing out that `find` will raise an error if there isn't a task group with that ID
* However, Rails will understand that when that specific error is raised, it should return a 404 response instead of an error

---

## Task Group Params

```rb
def task_group_params
  params.require(:task_group).permit(:title)
end
```

Note:
* Rails comes with a thing called strong parameters
* It basically lets us say specific params for an endpoint will be required or can be optional, and anything that isn't specified will get ignored.
* This doesn't need to be done in a separate method, but often times helps code from repeating
* In our case, the only param we're going to want for a task group is the name.

---

## Index Action

```rb
def index
  @task_groups = TaskGroup.all
end
```

Note:
* The first action we're going to make is going to be the `index`.

* Pretty simple, we're just grabbing all the task groups, and putting them in an instance variable
  * Instance variables in controllers are accessible to the views for an action
* If we wanted to, we could go more advanced than `all` and add pagination, or query params for filters, but that's not relevant at this time


### Index Action View

```html
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
* Pretty simple.
* Because it's so convention driven, Rails can figure out what the link for the `task_group` is for us, so we can focus on intention.

---

## Create Action

```rb
def new; end

def create
  if @task_group.save
    redirect_to task_group_url(@task_group), notice: "Task group was successfully created."
  else
    render :new, status: :unprocessable_entity
  end
end
```

Note:
* We have a task group getting created from the params via `set_task_group`
* We run save which will return true or false (running `save!` will raise an error), and either go back to the index page, or stay on the form if it's invalid


### New Action View

```html
<!-- app/views/task_groups/new.html.erb -->

<h1>New task group</h1>

<%= render "form", task_group: @task_group %>

<div>
  <%= link_to "Back to task groups", task_groups_path %>
</div>
```

Note:
* Only the `new` action needs a view
* We're going to have a partial for the task group form so it can be shared between the `new` and `edit` pages


### Form Partial

```html
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

* Notice that the file name starts with an underscore, this is to signify it's a partial.
* Form helpers aren't necessary, but they save you a lot of typing
* All that really matters is your inputs have the correct name

---

## Show Action

```rb
def show; end
```

Note:
* The show action is already done for us since we have `set_task_group`

### Show Action View

<!-- need a back button -->

```html
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

```rb
def edit; end

def update
  if @task_group.update(task_group_params)
    redirect_to task_group_url(@task_group), notice: "Task group was successfully updated."
  else
    render :edit, status: :unprocessable_entity
  end
end
```

Note:
* Similar to `new`/`create`, we've got `edit` and `update`
* Edit is just the action to show the form, and update is the actual endpoint that makes up the `PUT` request

* Also pretty similar to the `create` action, we're just running `update` with our sanitized params, and responding based on that outcome


### Edit Action View

```html
<!-- app/view/task_groups/edit.html.erb -->

<h1>Editing task group</h1>

<%= render "form", task_group: @task_group %>

<div class="mt-3">
  <%= link_to "Cancel", @task_group, class: "btn btn-outline-secondary" %>
</div>
```

Note:
* Because our form is in a partial, this view is pretty simple.

---

## Delete Action

Now for deleting task groups.

```rb
def destroy
  @task_group.destroy!
  redirect_to task_groups_url, notice: "Task group was successfully destroyed."
end
```

Note:
* We're going to run `destroy` with a `!` at the end so instead of `true`/`false` it raises an error if it fails
* After it runs, we'll take the user back to the task groups index page


### Delete Action UI

```html
<!-- app/views/task_groups/edit.html.erb (next to cancel button) -->

<%= button_to(
      "Destroy this task group",
      @task_group,
      method: :delete,
      class: "btn btn-danger mt-5"
    ) %>
```

Note:
* There's not a view necessarily, but we will need to essentially link to the action somewhere
* On the edit page, we can add this line at the bottom

* `button_to` is an interesting method
* It basically creates a form that's just a submit button, but gets routed to the destroy action

---

## Trying things out

<!-- get a video -->
<!-- Show that blank names return an error -->

Note:
* Alright, now that we have that code in place, let's see it in action.
* Make sure the server is running, no need to restart it if you never stopped it.
* Then go to `localhost:3000` and you should be able to do all the CRUD actions for a task group.

---

## Controller Tests

```rb
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
* I don't want to spend too much time getting into all of the tests, but I do want to show you generally what they can look like
* I'm going to highlight the new/create tests
* Test that the page will load and the response is good
* Then on create, we can really easily test that sending a `POST` request to the task groups endpoint actually causes a new one to be created
* The same applies to all the other resources

## System Tests

```rb
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
* Capybara is a tool included in Rails by default that can make writing e2e tests really easy
* Because these run in an actual browser through Selenium they're quite slow
* They also tend to be a little more flakey
* Mainly want to use these tests for user flows as they should be or critical edge cases, and push off the other stuff to integration tests

<!-- mention binding.irb for debugging browser tests? -->

### Running System Tests

```sh
rails test:system
# or
rails test path/to/test.rb
```

<!-- drop in a video of them running -->

Note:
* You don't need to already have the Rails server running for this
  * Though you do need the database and any other services up
* You can make these run headlessly as well

---

## Generate Task Resource

Note:
* Alright, let's create the actual task resource
* I'm going to go faster for these things, since it's fairly similar


```sh
rails g model Task \
  title:string \
  completed:boolean \
  due_at:datetime \
  task_group:references \
  --no-fixture
```

<!-- should I use task item instead? -->

Note:
* We're going to have some more fields for tasks
* Notice how this command has `task_group:references`
  * Rails uses this as a shorthand to create a column `task_group_id`, setup a foreign key constraint, and to create an index on it.

---

## Migration Update

```rb
t.string :title, null: false
t.boolean :completed, null: false, default: false
```

```sh
rails db:migrate
```

Note:
* Going to add `null: false` to the migration
* We're also going to specify that completed needs to be given, but can default it to false

---

## Task validation

```rb
# app/models/task.rb

class Task < ApplicationRecord
  belongs_to :task_group

  validates :title, presence: true
end
```

Note:
* Here's the model
* We can use `belongs_to` so specific instances of tasks can do `task.task_group` and automatically get the instance of the task group, which is slick
  * Doing this on the same instance of task will cache the task group, but you don't want to do this in a loop without using `includes`
* Also adding the title validation here too
* Because `completed` has a default value, we don't need to bother specifying that it's required here

---

## Add Relation to Task Group

```rb
# app/models/task_group.rb

class TaskGroup < ApplicationRecord
  has_many :tasks, dependent: :destroy

  validates :title, presence: true
end
```

Note:
* Back in the task group model, we can also say it has many tasks
  * Additionally, we're specifying when a task group is deleted we can also delete the tasks
* This lets us to `.tasks` and get the ActiveRecord instance of tasks for that task group

---

## Test Task Model

```rb
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

## Creating Tasks Controller

```rb
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

<!-- TODO: cut down empty methods in task groups controller -->

Note:
* This is nearly the same as the tasks group controller, so I'm going to move faster here
* The main thing you'll notice is we're not going to have actions for show or index
* The index will essentially be the show page for the task group
* Show just isn't needed
* I also have a two actions now, one to set the task group and one to set the task
  * Setting the task will be scoped to the set task group

---

## Task Controller Routing

```rb
resources :task_groups do
  resources :tasks, except: %i[index show]
end
```

```
/task_groups/:task_group_id/tasks
/task_groups/:task_group_id/tasks/:id
```

Note:
* For the routing, we're going to modify the resources call for task groups
* Add a block, then inside of that we add resources for tasks
* We're also excluding the index and show routes, so they won't be routed
  * If we didn't do this, then it'd be possible to access those routes but get a 500 error back instead of a 404

* I'm also going to draw attention to this `%i` array
* This is just shorthand for saying it's an array of strings
* We don't need to bother adding the colons or commas

---

## New Task Link

```html
<!-- app/views/task_groups/show.html.erb -->

<div class="mt-5">
  <div class="mb-3">
    <%= link_to "New task", new_task_group_task_path(@task_group), class: "btn btn-primary" %>
  </div>
</div>
```

Note:
* On the show task groups page, we're going to the new task page

---

## New Task Form

```html
<!-- app/views/tasks/new.html.erb -->

<h1>New task</h1>

<%= render "form", task_group: @task_group, task: @task %>

<div>
  <%= link_to "Back to tasks", task_group_path(@task_group) %>
</div>
```

```html
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
* The new task page looks like this

* Again we're following the the pattern of having a reusable form partial
* Notice how when we're specifying the model, we're giving both task and task group
* This is so rails is able to figure out what the action URL for this form should be

---

## Showing Tasks

```html
<!-- app/views/show.html.erb -->

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
* So now we can create tasks, but we still need to show them
* We're going to change the block we just added to the task group show page so that it looks like this

* This is a pretty slick thing Rails can do, by passing a collection of tasks, it will automatically find a partial for a single task

---

## Single Task Partial

```html
<!-- app/views/_task.html.erb -->

<%= tag.div(
  class: class_names(
    "list-group-item d-flex justify-content-between align-items-center",
    "list-group-item-success": task.completed
  )
) do %>
  <div>
    <h2>
      <%= task.title %>
    </h2>
    <% if task.due_at %>
      <p class="text-muted"><%= task.due_at %></p>
    <% end %>
  </div>

  <div class="d-flex">
    <% if task.completed %>
      <%= button_to(
            "Uncomplete",
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
* Here is the partial for a single task
* We're getting a little complicated, so we can break this down

* We're wrapping this stuff in a div, but we're creating it through the `tag.div` helper
* Not strictly necessary, but I prefer it when using a utility like `class_names`
* By the way, the `class_names` helper will let us pass in a hash, and any of the values that are `true` will get the key added as a class

* As we go down it's a little simple
* We're outputting the title
* If there's a due date, we're also adding that to the page
* We could specify a format for the due date, but the default will do for now

* We also want to clickly toggle the completion of a task
* It's not the best UX, but I wanted to avoid dipping into JavaScript
* We can use `button_to` which basically outputs a `form` element with hidden inputs
* This form is able to send a `PATCH` request which will hit the `update` action of the tasks controller
* So we just have an if statement that gives the button that will invert whatever the completion status of a task is

* Lastly, we're adding a button to link to the edit page

---

## Edit Task Page

```html
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
* This is pretty similar to the edit page for task groups
* Just putting the form on the page again
* Also using `button_to` to add a way to delete tasks

---

## Tasks Controller Tests

```rb
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
* Here's the tests for the tasks controller
* Since we're not doing anything fancy, these are nearly identical to the task groups controller tests

---

## Tasks E2E Tests

```rb
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

    assert_no_text "Uncomplete"

    click_button "Complete"

    assert_text "Task was successfully updated."
    assert_text "Uncomplete"
    assert_no_text "Complete"
  end

  test "uncompleting a task" do
    @task.update!(completed: true)
    visit task_group_url(@task_group)

    assert_no_text "Complete"

    click_button "Uncomplete"

    assert_text "Task was successfully updated."
    assert_text "Complete"
    assert_no_text "Uncomplete"
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
* Here's the system tests around tasks
* Again, these are nearly the same, so I'm not going to go into detail for these
* Just wanted to show they exist

---

## Model Scopes

Note:
* One of the cool things about ActiveRecord is it's composibility
* It doesn't actually do a query until you output a value or turn it into an array
* This makes it so you can just keep on chaining clauses and stuff to a model, and it will build a query that is effecient and removes any redundancies it knows about
* It also lets you create what Rails calls "scopes" to abstract specific queries
* These are essentially class methods that you can add to model queries

---

## Complete and Incomplete Scopes

```rb
# app/models/task.rb

class Task < ApplicationRecoord
  # ...

  scope :completed, -> { where(completed: true) }
  scope :incomplete, -> { where(completed: false) }
end
```

Note:
* Let's do a simple demonstration of this
* In the task model, we can create these scopes

* These are pretty simple examples, but now we're able to quickly get complete or incomplete tasks off of an existing query
* Because this abstracts our queries, it also means we only have one place to update code if we change how we actually define "complete"

* It's important to note that while you can do a bit of code that isn't SQL, these functions need to return active record queries, not arrays (or anything else)

---

## Using Our Scope

```html
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
* Using these scopes is pretty easy
* If we go to the task groups index view, we can modify our `link_to` tag to take a block
* Then in the block, we can add badges to show the count of complete and incomplete tasks

---

## Seeds

Note:
* Seeds are pretty cool
* They give you a starting point for data, which is helpful for poking around at in development
* Keep you having to create everything manually
  * Especially nice given the fact if you can reset your database which'll wipe your data

---

## Adding Seeds

```rb
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

```sh
rails db:seed

# or reset with
rails db:schema:load db:seed
```

Note:
* These seeds
  * Create a couple task groups
  * For each task group, creates 6 tasks
  * If the task number is not divisible by 2, then it will use that number of months from now as the due date

* We can run this with the `rails db:seed` command
* In our situation, running this multiple times will work
* But if you have uniqueness constraints, then you will want to reset your database first, or add checks before trying to recreate data

* There's also libraries that can help you organize and break up seeds
* If you have a lot of models, you probably don't want them all in one file

<!-- TODO: find out what that one library is -->

---

## FactoryBot

Note:
* One last thing I want to show is a package called FactoryBot
* It's a different approach to creating data in your tests than factories
* Similar to what we were doing by creating records as needed, but does so in a more resuable, and sustainable way

---

## Install FactoryBot

```rb
group :development, :test do
  # ...
  gem "factory_bot_rails"
end
```

```sh
bundle install
```

```rb
# test/test_helper.rb

class ActiveSupport::TestCase
  # ...
  include FactoryBot::Syntax::Methods
end
```

Note:
* FactoryBot can be used outside of Rails, but we're in Rails, so we're going to use an official version that gives us a few small niceties
* Also means you don't have to add the skip fixtures flag
* Better than fixtures because they're created only when we need them, and run model callbacks rather than going straight into the database
* We can also delete the `.keep` file in the fixtures directory
* In our case, we can also remove `fixtures :all` from the test setup

---

## Create Factories

```rb
# test/factories/task.rb

FactoryBot.define do
  factory :task do
    sequence(:title) { |n| "Task #{n}" }
    task_group
  end
end
```

```rb
# test/factories/task_groups.rb

FactoryBot.define do
  factory :task_group do
    sequence(:title) { |n| "Task Group #{n}" }

    trait :with_tasks do
      transient do
        tasks_count { 2 }
      end

      after(:create) do |task_group, evaluator|
        create_list(:task, evaluator.task_count, task_group: task_group)
      end
    end
  end
end
```

Note:
* Because out factories have the same name as our model, it's able to automatically figure out what class this is
* The factories are supposed to only be the minimum things required
* If something is needed for a test, then it should be specified in the test
* But in situations where we just need a task to exist but don't care about the details, we don't have to bother with them
* The impact of this isn't super obvious with just these two models, but these are a lot easier to manage than fixtures which can get very tangly pretty easily

* In the second one you can see we have the ability to define traits
* In this case, we can create a task group and specify it has tasks
* A transient attribute is just one that can be passed in, but doesn't actually exist on the model

---

## Use the Factories

```rb
# test/controllers/task_groups_controller_test.rb

setup do
  @task_group = create(:task_group)
end
```

```rb
# test/controllers/tasks_controller_test.rb

setup do
  @task = create(:task)
  @task_group = @task.task_group
end
```

```rb
# test/models/task_group_test.rb

setup do
  @task_group = build(:task_group)
end
```

```rb
# test/models/task_test.rb

setup do
  @task = build(:task)
end
```

```rb
# test/system/task_groups_test.rb

setup do
  @task_group = create(:task_group)
end
```

```rb
# test/system/tasks_test.rb

setup do
  @task = create(:task)
  @task_group = @task.task_group
end
```

Note:
* Since none of our tests actually care about the name, we can slim up our code
* Instances where we use reference a task and task group can just use the group that was created by creating a task

* Notice how in teh model tests we're using `build` instead of `create`
* These tests don't need the record to be saved, so we don't need to bother with that

---

## Get Some Users

First thing we're going to want is some users.
User management can be pretty difficult, but with the Devise gem it's really easy to hit the ground running.

Devise is a gem for rails that gives you a bunch of tools for common user management stuff.
It really shines when used in a MPA, but is still very useful when building an API only backend.

Inside the `Gemfile`, we're going to add `gem "devise"`.
Then back in the terminal, we're going to run `bundle install`.

After that, run `rails g devise:install`.
This will create a couple files, and give you some instructions to follow.

* Install devise
* Create user model
* Generate views
* Authorize a home page
* Have an index page that returns all for any user

---

## Test Authentication

* Add factorybot
* User model test
* Capybara test for logging in
* Controller test for authentication required
* Setting up mailhog

---

## Setting up pundit

* Add gem
* Require authentication
* Implement authentication and scope
* Test for requiring authentication on controller
* Tests for pundit code

---

## Cool things that are easy

* Ability to have collaborators on a task board
	* Adjust the pundit scopes and it just works
	* Mailers make sending invites easy
	* Just need a model for board accessible by
	* Easy to send emails when someone completes a task
	* Even easy to add webhooks to let multiple users see changes in real time
		* Note that actioncable scales weirdly
* Mailers for upcoming tasks that are due
* Zhoosh it up to be more SPA like with Turbo

---

## We made it

* LOC +/- since init

---

## Deploying

* Host the thing
* SMTP server
* Automate running migrations
* Just high level explain

---

## Namedropping

* Grape for APIs
* Strong migrations
* Linters
* Overmind
* Strong migrations
* RSpec
* Kaminari
* Rubymine
* Pry (and the console)
* Mailhog
* Bullet

---

## End

* Where to find code
* Presentation in word form

---

* Implement the app
	* Going to gloss over showing
		* Styling
		* Testing beyond the task board model
		* Some installations


<!-- TODO: add rubocop to make sure not doing anything bad apart from frozen_string_literal missing -->
<!-- TODO: ensure only vertical slides have ### heading -->
<!-- TODO: ensure all TODO items are resolved -->
<!-- TODO: who am I slide? -->
