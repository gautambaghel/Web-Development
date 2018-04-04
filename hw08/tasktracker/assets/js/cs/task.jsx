import React from 'react';
import { Button, FormGroup, Label, Input } from 'reactstrap';
import api from '../api';
import { connect } from 'react-redux';

export default function Task(params) {
  let task = params.task;
  return <tr>
        <td>{ task.user.name }</td>
        <td>{ task.title }</td>
        <td>{ task.description }</td>
        {task.completed ? ( <td> Yes </td> )
                    : ( <td> No </td> )}
        <td>{ task.time_spent }</td>
        <td>{ task.user_email_assigned }</td>
        <td>|</td>

        <td> <input type="checkbox" /> </td>
        <td> <input type="number" step="15" /></td>
        <td> <Button color="primary" >Update</Button></td>

    </tr>;
}
