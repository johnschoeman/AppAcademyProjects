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
