const FollowToggle = require('./follow_toggle');
const UsersSearch = require('./users_search');
const TweetCompose = require('./tweet_compose');
const InfiniteTweets = require('./infinite_tweets');

$(() => {
  $('.follow-toggle').each(function(index, button) {
    // debugger; --> why still logging even with debugger;
    let followToggle = new FollowToggle($(button));
    // console.log(followToggle);
  });
  $('.users-search').each(function(index, nav) {
    let usersSearch = new UsersSearch($(nav));
  });
  $('.tweet-compose').each(function(index, form) {
    let tweetCompose = new TweetCompose($(form));
  });

  $('.fetch-more').each(function(index, anchor) {
    let infiniteTweets = new InfiniteTweets($(anchor));
  });
});
