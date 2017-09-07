const APIUtil = require('./api_util');

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
