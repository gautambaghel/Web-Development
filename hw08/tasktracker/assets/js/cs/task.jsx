import React from 'react';
import { Card, CardBody } from 'reactstrap';

export default function Task(params) {
  let task = params.task;
  return <Card>
    <CardBody>
      <div>
        <p>Task by <b>{ task.user.name }</b></p>
        <p>{ task.description }</p>
      </div>
    </CardBody>
  </Card>;
}
