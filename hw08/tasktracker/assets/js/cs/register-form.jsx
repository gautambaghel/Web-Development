import React from 'react';
import { Button, FormGroup, Label, Input } from 'reactstrap';
import api from '../api';
import { connect } from 'react-redux';


function RegisterForm(props) {

  function update(ev) {
    let tgt = $(ev.target);

    let data = {};
    data[tgt.attr('name')] = tgt.val();
    let action = {
      type: 'UPDATE_REGISTER_FORM',
      data: data,
    };
    props.dispatch(action);
  }

  function register(ev) {
    api.submit_register(props.register);
  }

  return <div style={{padding: "4ex"}} className="col-6">
    <h2>Make a New Account</h2>
    <FormGroup>
      <Label for="name">Name</Label>
      <Input type="name" name="name" value={props.register.name} onChange={update}/>
    </FormGroup>
    <FormGroup>
      <Label for="email">Email</Label>
      <Input type="email" name="email" value={props.register.email} onChange={update} />
    </FormGroup>
    <FormGroup>
      <Label for="password">Password</Label>
      <Input type="password" name="password_hash" placeholder="password" value={props.register.password_hash} onChange={update} />
    </FormGroup>
    <Button onClick={register} color="primary" >Register</Button>
  </div>;
}

function state2props(state) {
  return {
    register: state.register
  };
}

export default connect(state2props)(RegisterForm);
