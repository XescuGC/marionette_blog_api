#Welcome to MarioneteBlogApi

This is an API that will be used for my MarionetteBlog in the future.

##How to start

*Before starting, this API uses MongoDB so you need to have it installed [mongodb install with brew](http://docs.mongodb.org/manual/tutorial/install-mongodb-on-os-x/)*

To run the project just install the gems:

    $> bundle

Then run the server:

    $> rackup

You can find it at [localhost::9292](http://localhost:9292/), it's an API so you won't see anithing :smiley:

##Run the Test

To run the test you can do it by the normal way:

    $> rspec spec/

Or using a Rake task

    $> rake spec

With the rake task you can specify 2 parameter that will refer to the folders of the spec direcotry:

    $> rake spec[api]
    $> rake spec[domine,interactors]
    $> rake spec[domine]
 
##Documentation

To generate the documentation:

    $> rdoc

##Domain-Driven Design (DDD)
