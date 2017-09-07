const APIUtil = require('./api_util');

class FollowToggle {
  constructor($el, options) {
    // debugger;
    this.userId = $el.data('user-id') || options.userId;
    this.followState = $el.data('initial-follow-state') || options.followState;
    this.$el = $el;
    this.$el.text(this.render());
    this.handleClick(this.$el);

  }

  handleClick($el) {
    $el.on('click', (event) => {
      event.preventDefault();

      if (this.followState === 'followed') {
        this.followState = 'unfollowing';
        this.render();
        APIUtil.unfollowUser(this.userId)
          .then(() => {
            this.followState = 'unfollowed';
            this.$el.text(this.render());
          });
      } else {
        this.followState = 'following';
        this.render();
        APIUtil.followUser(this.userId)
          .then(() => {
            this.followState = 'followed';
            this.$el.text(this.render());
          });
      }
    });
  }

  render() {
    this.$el.prop( "disabled", true );
    if (this.followState === 'followed') {
      this.$el.prop( "disabled", false );
      return 'Unfollow!';
    } else if (this.followState === 'unfollowed'){
      this.$el.prop( "disabled", false );
      return 'Follow';
    }
  }
}

module.exports = FollowToggle;
