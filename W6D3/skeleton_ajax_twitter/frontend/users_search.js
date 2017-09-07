const APIUtil = require('./api_util');
const FollowToggle = require('./follow_toggle');

class UsersSearch {
  constructor($el) {
    this.$el = $el;
    this.input = $el.find('input');
    this.ul = $el.find('ul');
    this.handleInput();
  }

  handleInput() {
    let navEl = this;
    this.input.on('change paste keyup', function() {
      APIUtil.searchUsers(this.value,
        UsersSearch.prototype.renderResults.bind(navEl));
    });
  }

  renderResults(res) {
    let $ul = this.ul;
    $ul.empty();
    res.forEach((searchRes) => {
      let $li = $('<li>');
      let $button = $('<button>');
      let userId = searchRes.id;
      let followState = searchRes.followed ? "followed" : "unfollowed";
      let followToggle = new FollowToggle($button, {userId: userId, followState: followState});
      $li.text(`${searchRes.username} ` );
      $li.append($button);
      $ul.append($li);
    });
  }
}

module.exports = UsersSearch;
