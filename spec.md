##Specifications for the Sinatra Assessment

#Specs:

 Use Sinatra to build the app
 Use ActiveRecord for storing information in a database
 Include more than one model class: Users, Trips, Destinations, TripDestinations (join table)
 Include at least one has_many relationship on your User model (Trips have many destinations, destinations have many trips, users have many trips_)
 Include at least one belongs_to relationship on another model (Trips belong to a user)
 Include user accounts (for User class)
 Ensure that users can't modify content created by other users -- used logged_in and current user helper methods throughout controllers for this purpose
 Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying -- Trips have all these routes
 Include user input validations -- included throughout controllers where form data is inputted or updated
 Display validation failures to user with error message (example form URL e.g. /posts/new) -- Implemented this throughout all controllers using Rack::Flash
 Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code

##Confirm

 You have a large number of small Git commits
 Your commit messages are meaningful
 You made the changes in a commit that relate to the commit message
 You don't include changes in a commit that aren't related to the commit message
