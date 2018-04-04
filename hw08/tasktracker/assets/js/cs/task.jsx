import React from 'react';
import { Button, FormGroup, Label, Input } from 'reactstrap';
import api from '../api';
import { connect } from 'react-redux';

function UpdateTaskForm(props) {

  function update(ev) {
    let tgt = $(ev.target);

    let data = {};
    if(tgt.attr('type') === "checkbox") {
      data[tgt.attr('name')] = tgt.is(':checked');
    } else {
      data[tgt.attr('name')] = ev.target.value;
    }

    let action = {
      type: 'UPDATE_TASK_FORM',
      data: data,
    };
    props.dispatch(action);
  }

  function updateTask(ev) {
      let tgt = $(ev.target);
      let thisButton = tgt.attr('name');
      let comName = "completed_" + thisButton;
      let timeSpentName = "time_spent_" + thisButton;

      let newComVal = props.task.completed;
      if(comName in props.update_task) {
        newComVal = props.update_task[comName];
      }

      let newTimeSpentVal = props.task.time_spent;
      if(timeSpentName in props.update_task) {
        newTimeSpentVal = props.update_task[timeSpentName];
      }

      let newTaskVal = Object.assign({}, props.task);
      newTaskVal.completed = newComVal;
      newTaskVal.time_spent = newTimeSpentVal;

      api.submit_update_task(newTaskVal,newTaskVal.id);
  }

  let task = props.task;
  let completedName = "completed_" + task.id;
  let timeSpentName =  "time_spent_" + task.id;
  return <tr>
        <td>{ task.user.name }</td>
        <td>{ task.title }</td>
        <td>{ task.description }</td>
        {task.completed ? ( <td> Yes </td> )
                    : ( <td> No </td> )}
        <td>{ task.time_spent }</td>
        <td>{ task.user_email_assigned }</td>
        <td>|</td>

        <td> <input type="checkbox" name={ completedName } onChange={update} /> </td>
        <td> <input type="number" step="15" name={ timeSpentName } onChange={update}/></td>
        <td> <Button color="primary" name= {task.id} onClick={updateTask} >Update</Button></td>
    </tr>;
}

function state2props(state) {
  return {
    update_task: state.update_task
  };
}

export default connect(state2props)(UpdateTaskForm);
