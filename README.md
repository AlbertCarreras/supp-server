# SUPP

## What's Supp?

Supp is a user-friendly app that sorts users by distance and filters them by common interests/hobbies. Users connect with each other via private chats. 

## Demo video

https://www.youtube.com/watch?v=yG3gEc1bC60&feature=youtu.be

## Technologies

### Front-end
Github:
Front-end 
https://github.com/AlbertCarreras/supp-client

React with Redux & Redux Thunk
    
  * **Redux and Redux Thunk** are key for all the asynchronous requests happening at a time. Redux helps keep and handle all the state from a single place while Thunk is indispensable to allow the app to work.

  * **Geolocation Web API** for obtaining user’s current location coordinates

    I used W3C Geolocation standard to request the browser the geolocation of the user. The request returns the latitude and longitude of the user which is persisted and used to georeference other nearby users.

    I research the best approach to obtain the location, and decided to go use the Geolocation Web API after reading the following: 
      >> "Some browsers use IP addresses to detect a user's location. However, it may only provide a rough estimate of a user's location. The W3C >> approach is the easiest and most fully-supported so it should be prioritized over other geolocation methods."
      >> https://developers.google.com/maps/documentation/javascript/geolocation
    
  * **Custom CSS** and **Semantic UI elements** for front-end design
  
    Most of the app is styled using custom CSS. Some elements such as the icons and the modals are Semantic UI elements.
    I decided to use Semantic UI elements because the library facilitated the front-end styling in previous projects. Moreover, I had in mind using modals and liked the examples from the library. However, I would refactor the modals and use custom CSS. 

  * **Bad-words (package)** for filtering profane language
  
    The search bar and the chat input bar do not allow to look for profane language. It is a very simple package but easily offers functionality to prevent some user behaviors.

### Back-end 
Github:
Back-end
https://github.com/AlbertCarreras/supp-server

Rails API with with serialization and Postgres
  * **Active Storage** for photo storage connected to AWS S3 in production
  
    I used the Rails built-in solution -Active Storage- to attach files to your Active Record models. Active Record also facilitates uploading files to a cloud storage service like Amazon S3.

    The server is hosted in Heroku. In order to deploy to Heroku and upload images, you need to create an AWS S3 account to store the files.
    
    Great resources for implementing Active Storage:
    * https://edgeguides.rubyonrails.org/active_storage_overview.html
    * https://devcenter.heroku.com/articles/active-storage-on-heroku
    * https://medium.com/cedarcode/rails-5-2-credentials-9b3324851336

  * **Action Cable** for live private chat feed updating and connected-user indicators
    
      Action Cable is the built-in websocket implementation in Rails. In order to facilitate the websocket connection from the React front-end, I decided to use **react-actioncable-provider (package)**.
      
      __Live private chats__ I initially implemented a simplified version of private chats that I posteriorly refactored into a more secure implementation. First, users were connecting to a general channel. New conversations were broadcasted to all users with serialized information about the 2 users to whom the conversation belongs to. In the front end, the received conversation was only displayed if one of the users was the logged-in user.
      
      When implemented user identification on the websocket connection, each user started connecting to a dynamic private user channel based on each user's id. Now, new conversations are just broadcasted to both sender/receiver users. On the client side, we still check if the conversation's users match the actual logged-in user.
    
      __Connected users indicators (blue-green dots)__ When a user logs in, they subscribe to a presence channel changing their status to active in the database  -reversely when disconnecting/unsubscribing. The change in status gets broadcasted to all subscribers.

      Great resources for implementing websockets in React-Rails apps:
      * https://medium.com/@dakota.lillie/using-action-cable-with-react-c37df065f296
      * https://blog.heroku.com/real_time_rails_implementing_websockets_in_rails_5_with_action_cable

  * **Knock** for JSON Web Token authentication and **cookies** for websocket-connection user identification
  
      I followed the __3.1.1 Connection Setup__ implementation guidelines from the Action Cable Overview documentation. However, I used JWT tokens for authorization. In order to pass the required cookies, the front-end generates a cookie containing the JWT token from localStorage and the server authorize the incoming connection if the user is identified in the JWT token.
    
      Great resources for creating cookies in the React front-end:
      * https://developer.mozilla.org/en-US/docs/Web/API/Document/cookie
    
  * **Geokit (gem)** for calculating surrounding users to connected user distance
  
      Users are sorted by distance in the front-end. The server responds with an array of users including the distance to the logged-in user. The gem calculates the distance based on the coordinates of each user obtained via Geolocation Web API.

  Database. The following image shows the database tables and relationships.
    <img width="698" alt="screen shot 2018-09-07 at 14 22 50" src="https://user-images.githubusercontent.com/10593890/45236338-92fbe900-b2a9-11e8-87f1-dd8a155de961.png">

### Notes on the used technologies  
As I was building the app, I made some decisions that down the project happen to become some technical debt. I decided to install Knock because it was a light auth package. I considered Devise but I found it too comprehensive for the scope of the project. 

Another decision was to use "React-actioncable-provider" to facilitate the implementation of Actioncable in the front end.

When implementing the websockets for live active-user indicator, I found out that Actioncable uses cookies to identify the user in the server (channels folder) and does not have access to the controllers folder. At first, I made the front-end create a cookie container the token so it could be picked up in the server and identify the user which works in local/development. However, this solution does not work in production. I deployed front-end and backend in different domains and cookies don't work cross-domain. 

Having used Devise, I could have scoped warden (https://www.sitepoint.com/create-a-chat-app-with-rails-5-actioncable-and-devise/).

Having not used "React-actioncable-provider", instead hard-coding all the action cable implementation, I could have passed some user information in the headers. 

The quickest -and not safe solution- was to pass the actual userId as a query parameter.

### Notes on next steps
- Implementing some tests (Rspec in the back end and Mocha in the front end) 
- Organizing the CSS code implementing LESS or new CSS3 functionality. Fixing some CSS issues.
- Improving the algorithm for returning users by proximity and interests so it works with large datasets.

## Authors

ALBERTO CARRERAS
* acarrerasc @gmail.com
* https://github.com/AlbertCarreras
* https://medium.com/@a.carreras.c/
* https://www.linkedin.com/in/albertcarreras/en

I also want to thank Mike Chen () and Matt Lawford (https://www.linkedin.com/in/matthew-lawford-216b67b2/) for their technical support during the project development.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgment

I'm a board game geek. I love playing Dominion, Carcassonne, Star Realms, 7 Wonders, and so forth. I landed in NYC 6 years ago now and have found that it takes a lot of effort to meet and/or "connect" with people to play board games: you have to go to board games stores, your friends live really far, and more. 

At the same time, NYC has so many passionate people out there and is not difficult to find people who love the same things you love. However, despite having apps such as Meetup, I wanted to create a more genuine app to find people who share my same hobbies or passions and who actually live or are regularly nearby; start a conversation, and plan to meet to do those activities or experience them together. 

Supp is an app to enhance the experience of meeting new people and making new friends. 