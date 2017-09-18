import React from 'react';
import { connect } from 'react-redux';
import { withRouter } from 'react-router-dom';
import SessionForm from './session_form';
import { login, signup } from '../../actions/session_actions';

const mapStateToProps = (state, ownProps) => {
  const formType = ownProps.location.pathname.slice(1);
  return (
    {
      loggedin: Boolean(state.session.currentUser),
      errors: state.errors.session,
      formType
    }
  );
};

const mapDispatchToProps = (dispatch, ownProps) => {
  let action = (ownProps.location.pathname === '/login') ? (login) : (signup);
  return (
    {
      processForm: (user) => dispatch(action(user))
    }
  );
};

export default withRouter(connect(mapStateToProps, mapDispatchToProps)(SessionForm));
