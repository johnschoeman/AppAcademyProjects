import React          from 'react';
import { connect }    from 'react-redux';
import { withRouter } from 'react-router-dom';
import { logout }      from '../../actions/session_actions';
import Greeting       from './greeting';

const mapStateToProps = (state, ownProps) => {
  return ({
    currentUser: state.session.currentUser
  });
};

const mapDispatchToProps = (dispatch, ownProps) => {

  return ({
    logout: () => (dispatch(logout()))
  });
};

export default withRouter(connect(
                          mapStateToProps,
                          mapDispatchToProps)(Greeting));
