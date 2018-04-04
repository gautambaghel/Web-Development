import React from 'react';

export default function Task(params) {
  let task = params.task;
  return <tr>
        <td>{ task.user.name }</td>
        <td>{ task.title }</td>
        <td>{ task.description }</td>
        {task.completed ? ( <td> <input type="checkbox" checked/></td> )
                    : ( <td> <input type="checkbox"/></td> )}
        <td>{ task.time_spent }</td>
        <td>{ task.user_email_assigned }</td>
    </tr>;
}
