  // Brunch automatically concatenates all files in your
  // watched paths. Those paths can be configured at
  // config.paths.watched in "brunch-config.js".
  //
  // However, those files will only be executed if
  // explicitly imported. The only exception are files
  // in vendor, which are never wrapped in imports and
  // therefore are always executed.

  // Import dependencies
  //
  // If you no longer want to use a dependency, remember
  // to also remove its path from "config.paths.watched".
  import "phoenix_html";
  import $ from "jquery";

  // Import local files
  //
  // Local files can be imported directly using relative
  // paths "./socket" or full ones "web/static/js/socket".

  // import socket from "./socket"

  function update_buttons() {
      $('.manage-button').each( (_, bb) => {
        let user_id = $(bb).data('user-id');
        let manage = $(bb).data('manage');
        if (manage != "") {
          $(bb).text("Unmanage");
        }
        else {
          $(bb).text("manage");
        }
      });

      $('.work-button').each( (_, bb) => {
        let task_id = $(bb).data('task-id');
        let status = $(bb).data('timeblock-status');

        if (status) {
          $(bb).text("Stop Working");
        }
        else {
          $(bb).text("Start Working");
        }
      });
  }

  function set_button(id, value) {
      $('.manage-button').each( (_, bb) => {
        if (id == $(bb).data('user-id')) {
          $(bb).data('manage', value);
        }
      });

      update_buttons();
  }

  function manage(user_id) {
      let text = JSON.stringify({
        manage: {
            manager_id: current_user_id,
            managee_id: user_id
          },
      });

      $.ajax(manage_path, {
        method: "post",
        dataType: "json",
        contentType: "application/json; charset=UTF-8",
        data: text,
        success: (resp) => { set_button(user_id, resp.data.id); },
      });
  }

  function unmanage(user_id, manage_id) {
      $.ajax(manage_path + "/" + manage_id, {
        method: "delete",
        dataType: "json",
        contentType: "application/json; charset=UTF-8",
        data: "",
        success: () => { set_button(user_id, ""); },
      });
  }

  function manage_click(ev) {
      let btn = $(ev.target);
      let manage_id = btn.data('manage');
      let user_id = btn.data('user-id');

      if (manage_id != "") {
        unmanage(user_id, manage_id);
      }
      else {
        manage(user_id);
      }
  }

  function get_current_timestamp(){
          
          var date = new Date();
          var time = new Date().getTime(); 
          date.setTime(time);

          var milliSeconds = pad(date.getMilliseconds(),6);
          var seconds = pad(date.getSeconds(),2);
          var minutes = pad(date.getMinutes(),2);
          var hour = pad(date.getHours(),2);

          var year = date.getFullYear();
          var month = pad(date.getMonth()+1,2); // beware: January = 0; February = 1, . Padding to 01,02,...12
          var day = date.getDate();

          return String(year)+"-"+String(month)+"-"+String(day)+"T"+String(hour)+":"+String(minutes)+":"+String(seconds)+"."+String(milliSeconds);
  }

  function pad(num, size) {
      var s = num+"";
      while (s.length < size) s = "0" + s;
      return s;
  }

  function start_working(task_id) {

      let timestamp = get_current_timestamp();
      
          let text = JSON.stringify({
            time_block: {
                task_id: task_id,
                time_beg: timestamp,
                time_end: '2000-01-01T00:00:00.000000'              
            },
          });
      $.ajax(timeblocks_path, {
        method: "post",
        dataType: "json",
        contentType: "application/json; charset=UTF-8",
        data: text,
        success: (resp) => { location.reload(); },
      });
    }

  function stop_working(task_id,last_timeblock_id) {
    
    console.log(last_timeblock_id);
    $.ajax(timeblocks_path + "/" + last_timeblock_id, { 
        method: 'GET', 
        data: { get_param: 'value' }, 
        dataType: 'json',
        contentType: "application/json; charset=UTF-8",
        success: (resp) => { 
          let time_beg = String(resp.data.time_beg); 
          let timestamp = get_current_timestamp();
          
          let text = JSON.stringify({
            time_block: {
                  task_id: task_id,
                  time_beg: time_beg,
                  time_end: timestamp              
              },
            });

          $.ajax(timeblocks_path + "/" + last_timeblock_id, {
                  method: "put",
                  dataType: "json",
                  contentType: "application/json; charset=UTF-8",
                  data: text,
                  success: (resp) => { location.reload(); },
                });
       },
    });     
  }

  function work_click(ev) {
    let btn = $(ev.target);
    let task_id = btn.data('task-id');
    let status = btn.data('timeblock-status');
    let last_timeblock_id = btn.data('timeblock-last-id');
    
    if(status){
       stop_working(task_id,last_timeblock_id);
    } else {
       start_working(task_id);
    }
  }

  function delete_worktime(task_id, timeblock_id) {
    $.ajax(timeblocks_path + "/" + timeblock_id, {
      method: "delete",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      data: "",
      success: () => {  location.reload(); },
    });
  }

  function time_delete_click(ev) {
    let btn = $(ev.target);
    let task_id = btn.data('task-id');
    let timeblock_id = btn.data('timeblock-id');

    delete_worktime(task_id,timeblock_id);
  }

  function update_worktime(task_id, timeblock_id, time_beg, time_end) {
    let text = JSON.stringify({
            time_block: {
                  task_id: task_id,
                  time_beg: time_beg,
                  time_end: time_end              
              },
            });

    $.ajax(timeblocks_path + "/" + timeblock_id, {
      method: "put",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      data: text,
      success: () => {  location.reload(); },
    });
  }

  function time_update_click(ev) {
    let btn = $(ev.target);
    let task_id = btn.data('task-id');
    let timeblock_id = btn.data('timeblock-id');
    let row = btn.data('timeblock-row');

    console.log(row);

    update_worktime(task_id, timeblock_id);
  }

  function init_manage() {
    if (!$('.manage-button') || 
      !$('.work-button') ||
      !$('.time-delete-button') ||
      !$('.time-update-button')){
      return;
    }

    $('.manage-button').click(manage_click);
    $('.work-button').click(work_click);
    $('.time-delete-button').click(time_delete_click);
    $('.time-update-button').click(time_update_click);

    update_buttons();
  }

  $(init_manage);
