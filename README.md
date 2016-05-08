# TV Show Lister

This is an app that allows users to add their favorite shows to a list of TV shows. The list keeps track of details about the show based on the user input.

I built this mainly to practice acceptance testing using Capybara. All features have an associated user story, as well as an acceptance test ensuring it works as expected. I wrote each test first, then let the failing test drive my development.

The app was built using Sinatra.

## User Stories

```no-highlight
 As a TV fanatic
 I want to view a list of my TV shows
 So I can keep track of and share all my favorite shows
```
#### Acceptance Criteria:
 * User can see names and networks of all TV shows that have been added

```no-highlight
 As a TV fanatic
 I want to add one of my favorite shows
 So that I can encourage others to binge watch it
```
#### Acceptance Criteria:
 * User must provide the title, network, starting year, genre, and synopsis
 * Genre must be one of the following: Action, Mystery, Drama, Comedy, Fantasy
 * If any of the above criteria is left blank, the form is re-displayed with the failing validation message

```no-highlight
As an organized TV fanatic
I want to receive an error message if I try to add the same show twice
So that I don't have duplicate entries
```
#### Acceptance Criteria:
* If the title is the same as a show that's already been added, the details are not saved to the csv
* If the title is the same as a show that's already been added, user will be shown an error message.
* If the details of the show are not saved, user remains on the new form page

## Models:

### `TelevisionShow`

* Objects initialized with:
  * title
  * network
  * starting year
  * genre
  * synopsis

* Class Methods:
  * `all`
    * returns an array of `TelevisionShow` objects whose attributes correspond to each data row in the csv file
* Instance Methods:
  * `errors`
    * returns an empty array until `valid?` returns errors
  * `valid?`
    * returns true if the two following validations are true:
      1. None of the attributes of the instance object are empty strings
      2. The `title` attribute of the instance object is not present in the csv file
  * `save`
    * returns true and add object attributes to csv if the object is valid. Returns false it the object is not valid
