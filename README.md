# imgrrr
Project: Imgrrr


approach to solving

cool tech
lessons i've learnt

future features

## Planning:

![Potential Pages]()
![Data Structure]()
![Login/Sign Up Page]()
![Login Pseudo]()
![Sign Up Pseudo]()
![Home/User Page]()
![Album Page]()
![Image Page]()


## Approach:

## Lessons Learnt:

* SQL indexes start at 1 (at list TEXT indexes do)
* Using Sinatra Sessions is better than using Rack.Session

## Cool Tech:

### Fuzzy matching:

Used to search for usernames similar to a given string by looking for asubstring of string in each username and scoring them accodingly.
[Fuzzy match](https://www.sqlservercentral.com/articles/fuzzy-search)
    

## Known Bugs:

*   Fuzzy matching doesn't work quite as expected
* No default image / cover image when add new image / album
* Album/image title+description can exceed container size causing display issues
* Album/image description can be empty
* No password recovery function
* (That one I forgot about -.-)

## Future Features:

* Password recovery
* Generate Default image / album cover image. Potentially using an API like [PlaceGoat](https://placegoat.com/)
* Comments section
* Voting System
* Favourited albums / images (On other user's pages)
* Unsorted Images folder for saving images without an album
* Interface with [imgur](https://imgur.com/)'s API
