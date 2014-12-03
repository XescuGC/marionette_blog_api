[![Build Status](https://travis-ci.org/XescuGC/marionette_blog_api.svg?branch=master)][travis]

[travis]: https://travis-ci.org/XescuGC/marionette_blog_api 
#Welcome to MarioneteBlogApi

This is an API that will be used for my MarionetteBlog in the future.

##How to start

*Before starting, this API uses MongoDB so you need to have it installed [mongodb install with brew](http://docs.mongodb.org/manual/tutorial/install-mongodb-on-os-x/)*

To run the project just install the gems:

    $> bundle

Then run the server:

    $> rackup

You can find it at [localhost::9292](http://localhost:9292/), it's an API so you won't see anything :smiley:

###Gems used and why

This project uses basically 3 gems:

  * **Perpetuity(-mongodb):** This geme give a flexible Data Mapper for MongoDB (Repositories).
  * **Virtus:** Used to create the Entities/Models of the Domine.
  * **Grape:** Flexible Ruby DSL to build APIs.

##Run the Test

To run the test you can do it by the normal way:

    $> rspec spec/

Or using a Rake task

    $> rake spec

With the rake task you can specify 2 parameters that will refer to the folders of the spec direcotry:

    $> rake spec[api]
    $> rake spec[domine,interactors]
    $> rake spec[domine]
 
##Documentation

To generate the documentation:

    $> rdoc

##Domain-Driven Design (DDD)

This API uses [DDD](http://en.wikipedia.org/wiki/Domain-driven_design) set of patterns (more or less) you will see that the business logic is separeted from the rest of the app. All this business logic and business rules are stored at the `domain/` folder.

In this folder we can found:

  * **Entities:** The Place for the Domine Objects, in this case the Post and Tag.
  * **Interactors:** The Place for the Buisines Logic, each file is a USE CASE of the Domine Objec.
  * **Repositories:** Mappers that interacts with the DB, to store, delete, update or finde Objects.

Basically what you achieve with this structure is to focus your development in what is important, the Domine. When this part is done, then you can proceed to add the Domine to whatever you whant, because it don't have any outside dependence, you could even create a gem with it and install it in you project and it will work.

Fore more information about this structure see Robert C. Martin, aka, Uncle Bob that has a really good [video](https://www.youtube.com/watch?v=WpkDN78P884).
