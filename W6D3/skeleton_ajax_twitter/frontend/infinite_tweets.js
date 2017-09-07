const APIUtil = require('./api_util');

class InfiniteTweets {
  constructor($anchor) {
    this.maxCreatedAt = null;
    this.$anchor = $anchor;
    this.$anchor.on('click',() => {
      this.fetchTweets();
      return false;
    });
  }

  fetchTweets() {
    if(this.maxCreatedAt !== null) {
      var data = this.maxCreatedAt;
    }
    console.log(data);
    APIUtil.fetchTweets(data)
      .then((res) => {
        this.insertTweets(res);
      });
    return false;
  }

  insertTweets(res) {
    let $ul = $('#feed');
    res.forEach((tweet) => {
      let $li = $('<li>');
      $li.text(JSON.stringify(tweet));
      $li.data('created_at', tweet.created_at);
      $ul.append($li);
    });
    let lastTweet = $('#feed li').last();
    this.maxCreatedAt = lastTweet.data('created_at');
    return false;
  }
}

module.exports = InfiniteTweets;
