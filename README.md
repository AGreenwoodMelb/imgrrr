# imgrrr

An attempt to make a link manager site styled after [Imgur](https://imgur.com/)

 (Please don't sue me imgur)

The main focus was on security and preventing users from accessing or editing things they aren't supposed to through manipulation of the URL

## Planning:

* [Potential Pages](https://github.com/AGreenwoodMelb/imgrrr/blob/master/README/potential-pages.jpg)
* [Data Structure](https://github.com/AGreenwoodMelb/imgrrr/blob/master/README/data-structure.jpg)
* [Login/Sign Up Page](https://github.com/AGreenwoodMelb/imgrrr/blob/master/README/login-signup-page.jpg)
* [Login Pseudo](https://github.com/AGreenwoodMelb/imgrrr/blob/master/README/login-pseudo.jpg)
* [Sign Up Pseudo](https://github.com/AGreenwoodMelb/imgrrr/blob/master/README/signup-pseudo.jpg)
* [Home/User Page](https://github.com/AGreenwoodMelb/imgrrr/blob/master/README/user-home-page.jpg)
* [Album Page](https://github.com/AGreenwoodMelb/imgrrr/blob/master/README/album-page.jpg)
* [Image Page](https://github.com/AGreenwoodMelb/imgrrr/blob/master/README/image-page.jpg)


## Approach:

1. Panic!
2. Plan data structure and wireframess
3. Code back-end functionality
4. Build basic front-end to access back-end
5. Apply css styling and cosmetics to from end
6. Test and bug fix

## Lessons Learnt:

* SQL indexes start at 1 (at least TEXT indexes do)
* Using Sinatra Sessions is better than using Rack.Session
* Customizing checkboxes with HTML and CSS is difficult

## Cool Tech:

* ### Fuzzy matching:
    Used to search for usernames similar to a given string by looking for asubstring of string in each username and scoring them accodingly. Adapted from
[Fuzzy match](https://www.sqlservercentral.com/articles/fuzzy-search)
    

## Known Bugs:

*   Fuzzy matching doesn't work quite as expected
* No default image / cover image when add new image / album
* Album/image title+description can exceed container size causing display issues
* Album/image description can be empty
* No password recovery function
* Spelling mistakes and typos EVERYWHERE
* Probably some kind of Copyright infringement that Imgur will kneecap me over
* (That one I forgot about -.-)
* The image previews on the Album page need to have a max height
* Card layout changes dependent on cover image dimension
## Future Features:

* Password recovery
* Generate Default image / album cover image. Potentially using an API like [PlaceGoat](https://placegoat.com/)
* Comments section
* Voting System
* Favourited albums / images (On other user's pages)
* Unsorted Images folder for saving images without an album
* Interface with [imgur](https://imgur.com/)'s API
