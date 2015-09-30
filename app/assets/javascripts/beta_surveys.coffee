# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@updateCheckbox = (group_id) ->
  switch group_id
    when "how_manage_warehouse"
      text_field_value = document.getElementById('how_manage_warehouse_other_text').value
      console.log typeof text_field_value
      document.getElementById('beta_survey_how_manage_warehouse_other').setAttribute 'value', 'Other: ' + text_field_value
    when "how_manage_vehicles"
      text_field_value = document.getElementById('how_manage_vehicles_other_text').value
      console.log typeof text_field_value
      document.getElementById('beta_survey_how_manage_vehicles_other').setAttribute 'value', 'Other: ' + text_field_value
    when "how_bookings_done"
      text_field_value = document.getElementById('how_bookings_done_other_text').value
      console.log typeof text_field_value
      document.getElementById('beta_survey_how_bookings_done_other').setAttribute 'value', 'Other: ' + text_field_value
    when "how_heard"
      text_field_value = document.getElementById('how_heard_other_text').value
      console.log typeof text_field_value
      document.getElementById('beta_survey_how_heard_other').setAttribute 'value', 'Other: ' + text_field_value
  return

@check = (group_id) ->
  switch group_id
    when "how_manage_warehouse"
      document.getElementById('beta_survey_how_manage_warehouse_other').checked = true
    when "how_manage_vehicles"
      document.getElementById('beta_survey_how_manage_vehicles_other').checked = true
    when "how_bookings_done"
      document.getElementById('beta_survey_how_bookings_done_other').checked = true
    when "how_heard"
      document.getElementById('beta_survey_how_heard_other').checked = true
  return
