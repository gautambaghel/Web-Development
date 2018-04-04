import React from 'react';
import Task from './task';

export default function Tasks(params) {
  let tasks = _.map(params.tasks, (pp) => <Task key={pp.id} task={pp} />);
  return <div>
  <table className="table">
    <thead>
      <tr>
        <th>Assignor</th>
        <th>Title</th>
        <th>Description</th>
        <th>Completed</th>
        <th>Time Spent</th>
        <th>Assignee</th>
      </tr>
    </thead>
    <tbody>
    { tasks }
   </tbody>
  </table>
  </div>;
}
