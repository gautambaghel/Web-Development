import React from 'react';
import ReactDOM from 'react-dom';
import { Provider, connect } from 'react-redux';
import { BrowserRouter as Router, Route } from 'react-router-dom';

import Nav from './nav';
import Tasks from './tasks';
import Users from './users';
import TaskForm from './task-form';
import RegisterForm from './register-form';

export default function tasktracker_init(store) {
  ReactDOM.render(
    <Provider store={store}>
      <Tasktracker state={store.getState()} />
    </Provider>,
    document.getElementById('root'),
  );
}

let Tasktracker = connect((state) => state)((props) => {

  let task_form;
  if (props.token) {
    task_form = <div>
     <TaskForm />
     <Tasks tasks={props.tasks} />
    </div>;
  }
  else {
    task_form = <RegisterForm />;
  }

  return (
    <Router>
      <div>
        <Nav />
        <Route path="/" exact={true} render={() =>
          <div>
            {task_form}
          </div>
        } />
        <Route path="/users" exact={true} render={() =>
          <Users users={props.users} />
        } />
        <Route path="/users/:user_id" render={({match}) =>
          <Tasks tasks={_.filter(props.tasks, (pp) =>
            match.params.user_id == pp.user.id )
          } />
        } />
      </div>
    </Router>
  );
});
