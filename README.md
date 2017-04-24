# Project 4 - Twiltter Redux

Time spent: 16 hours spent in total

## User Stories

The following **required** functionality is completed:

- [x] Hamburger menu
   - [x] Dragging anywhere in the view should reveal the menu.
   - [x] The menu should include links to your profile, the home timeline, and the mentions view.
   - [x] The menu can look similar to the example or feel free to take liberty with the UI.
- [x] Profile page
   - [x] Contains the user header view
   - [x] Contains a section with the users basic stats: # tweets, # following, # followers
- [x] Home Timeline
   - [x] Tapping on a user image should bring up that user's profile page

The following **optional** features are implemented:

- [ ] Profile Page
   - [ ] Implement the paging view for the user description.
   - [ ] As the paging view moves, increase the opacity of the background screen. See the actual Twitter app for this effect
   - [ ] Pulling down the profile page should blur and resize the header image.
- [ ] Account switching
   - [ ] Long press on tab bar to bring up Account view with animation
   - [ ] Tap account to switch to
   - [ ] Include a plus button to Add an Account
   - [ ] Swipe to delete an account


The following **additional** features are implemented:

- [ ] List anything else that you can get done to improve the app functionality!

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

  1. Were you able to get the menu view to use the delegate pattern? I had an idea of how to do it but I didn't have enough time to try it.
  2. Did you face difficulty with adding the tap gesture recognizer to the images in the home timeline?


## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='http://i.imgur.com/OuYX26U.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Describe any challenges encountered while building the app.
I had a lot of trouble with adding the tap gesture recognizer to the home timeline profile images. I think I wasn't correctly adding the gesture recognizer/enabling user interaction. When I tried to click on the profile images, the app would only register that the cell which contained the profile image had been selected, and would segue me to the Tweet Detail View Controller. Instead, I could only add the gesture recognizer to the Tweet Detail view controller. Also, I couldn't figure out how to set the hamburger view controller's content view through that tap gesture, so when I perform the segue, I lose the hamburger view and can't go back. These are glaring flaws in my app that I couldn't figure out and this assignment did a number to my confidence since I couldn't complete the required features as expected.

## License

    Copyright 2017 Leland Tran

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

# Project 3 - *Twiltter*

**Twiltter** is a basic twitter app to read and compose tweets from the [Twitter API](https://apps.twitter.com/).

Time spent: **18** hours spent in total

## User Stories

The following **required** functionality is completed:

- [x] User can sign in using OAuth login flow.
- [x] User can view last 20 tweets from their home timeline.
- [x] The current signed in user will be persisted across restarts.
- [x] In the home timeline, user can view tweet with the user profile picture, username, tweet text, and timestamp.  In other words, design the custom cell with the proper Auto Layout settings.  You will also need to augment the model classes.
- [x] User can pull to refresh.
- [x] User can compose a new tweet by tapping on a compose button.
- [x] User can tap on a tweet to view it, with controls to retweet, favorite, and reply.

The following **optional** features are implemented:

- [x] When composing, you should have a countdown in the upper right for the tweet limit.
- [ ] After creating a new tweet, a user should be able to view it in the timeline immediately without refetching the timeline from the network.
- [ ] Retweeting and favoriting should increment the retweet and favorite count.
- [ ] User should be able to unretweet and unfavorite and should decrement the retweet and favorite count.
- [x] Replies should be prefixed with the username and the reply_id should be set when posting the tweet,
- [x] User can load more tweets once they reach the bottom of the feed using infinite loading similar to the actual Twitter client.

The following **additional** features are implemented:

- [ ] List anything else that you can get done to improve the app functionality!

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. Did you run into issues where you realized Storyboard's shortcomings? I could not find out how to put a label in the navigation bar using Storyboard
2. Did you have enough time to refactor all of your code to your complete satisfaction? I did not have enough time to refactor out some code to utility classes.

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='http://i.imgur.com/1zbvg30.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Describe any challenges encountered while building the app.

I didn't have time to figure out how to add labels to the navigation bar programmatically. 
I wish I had more time to think about refactoring code, but I think I'm finally starting to understand the Swift-way for MVC.

Image credits:

http://www.danilodemarco.com/
https://www.iconfinder.com/icons/299063/heart_icon#size=128
https://www.iconfinder.com/icons/115642/retweet_icon#size=128

## License

    Copyright 2017 Leland Tran

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
