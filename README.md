# RottenTomatoes Box Office Demo


This is an iOS demo application for displaying the latest box office movies using the [RottenTomatoes API](http://www.rottentomatoes.com/). 

Time spent: About 15 hours in total

Completed user stories:

* [x] Required: User can view a list of latest box office movies including title, cast and tomatoes rating
* [x] Required: User can click on a movie in the list to bring up a details page with additional information such as synopsis
* [x] Required: User can view a list of movies from Rotten Tomatoes. Poster images must be loading asynchronously.
* [x] Required: User can view movie details by tapping on a cell.
* [x] Required: User sees loading state while waiting for movies API. 
* [x] Required: User sees error message when there's a networking error. 
* [x] Required: User can pull to refresh the movie list. 
* [x] Optional: Add a tab bar for Box Office and DVD. 
* [x] Optional: Add a search bar. 
* [x] Optional: For the large poster, load the low-res image first, switch to high-res when complete (optional)
* [x] Optional: Customize the navigation bar. 
* [x] Optional: Placeholder image is used for movie posters loaded in from the network

Not completed user stories:

* [ ] Optional: Customize the highlight and selection effect of the cell. 
* [ ] Optional: Implement segmented control to switch between list view and grid view (optional)
* [ ] Optional: All images fade in 

Notes:

Spent a lot of time getting the table to scroll.
Also spent quite a bit of time getting the search to work and removing search related bugs.

Tried using AFNetworking for images fading in but couldn't figure out the block syntax to make it work :-/
Didn't get around to implementing segmented control to switch between list and grid views.

I had ideas on making the UI cleaner and updating labels to show relevant info in the table and detail views, 
but I only implemted as much as possible before the deadline.

This was a great learning experience, learnt about table views, asynchronous loading, putting a cell in table view, tab bar.

3rd party libraries used:

SVProgressHUD
AFNetworking


Walkthrough of all user stories:

![Video Walkthrough](rotten_tomatoes_demo.gif)

GIF created with [LiceCap](http://www.cockos.com/licecap/).

