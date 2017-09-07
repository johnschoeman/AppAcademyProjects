/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, {
/******/ 				configurable: false,
/******/ 				enumerable: true,
/******/ 				get: getter
/******/ 			});
/******/ 		}
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ (function(module, exports, __webpack_require__) {

const FollowToggle = __webpack_require__(1);
const UsersSearch = __webpack_require__(3);
const TweetCompose = __webpack_require__(4);
const InfiniteTweets = __webpack_require__(5);

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


/***/ }),
/* 1 */
/***/ (function(module, exports, __webpack_require__) {

const APIUtil = __webpack_require__(2);

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


/***/ }),
/* 2 */
/***/ (function(module, exports) {

const APIUtil = {
  followUser: (id) => {
    return $.ajax({
      url: `/users/${id}/follow`,
      method: 'POST',
      dataType: 'json'
    });
  },
  unfollowUser: (id) => {
    return $.ajax({
      url: `/users/${id}/follow`,
      method: 'DELETE',
      dataType: 'json'
    });
  },

  searchUsers: (queryVal, successCB) => {
    return $.ajax({
      url: '/users/search',
      method: 'GET',
      dataType: 'json',
      data: {query: queryVal},
      success: res => {
        successCB(res);
      }
    });
  },

  createTweet: (data) => {
    return $.ajax({
      url: '/tweets',
      method: 'POST',
      dataType: 'json',
      data: data
    });
  },

  fetchTweets: (data) => {
    return $.ajax({
      url: '/feed',
      method: 'GET',
      dataType: 'json',
      data: { max_created_at: data }
    });
  }
};

module.exports = APIUtil;


/***/ }),
/* 3 */
/***/ (function(module, exports, __webpack_require__) {

const APIUtil = __webpack_require__(2);
const FollowToggle = __webpack_require__(1);

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


/***/ }),
/* 4 */
/***/ (function(module, exports, __webpack_require__) {

const APIUtil = __webpack_require__(2);

class TweetCompose {
  constructor($form) {
    this.$form = $form;
    this.$form.on('submit', (event) => {
      event.preventDefault();
      this.submit();
    });
    this.$textarea = this.$form.find('textarea');
    this.$textarea.on('change keyup paste', () => {
      $('.chars-left').text(`${140-this.$textarea.val().length} characters left`);
    });
    $('.add-mentioned-user').on('click', () => {
      this.addMentionedUser();
    });
    $('.mentioned-users').on('click', (event) => {
      this.removeMentionedUser(event);
    });
  }

  removeMentionedUser(event) {
    let targetAnchor = event.target;
    let anchorParent = $(targetAnchor).parent();
    if ($(targetAnchor).text() === "Remove Mention") {
      anchorParent.remove();
    }
  }

  addMentionedUser() {
    let $scriptTag = $('#add-mention-script');
    let scriptHtml = $scriptTag.html();
    let $div = $('.mentioned-users');

    $div.append(scriptHtml);
    return false;
  }

  submit() {
    this.$form.find('input').prop('disabled', true);
    APIUtil.createTweet(this.$form.serializeJSON())
        .then((res) => {
          this.handleSuccess(res);
        });
  }

  handleSuccess(res) {
    this.clearInput();
    this.$form.find('input').prop('disabled', false);
    let tweetJSON = JSON.stringify(res.content);
    let $ul = $('#feed');
    $ul.prepend(`<li>${tweetJSON}</li>`);
  }

  clearInput() {
    this.$form.find('textarea').val("");
    this.$form.find('strong').text("");
    $('.mentioned-users').empty();
  }



}

module.exports = TweetCompose;


/***/ }),
/* 5 */
/***/ (function(module, exports, __webpack_require__) {

const APIUtil = __webpack_require__(2);

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


/***/ })
/******/ ]);
//# sourceMappingURL=bundle.js.map