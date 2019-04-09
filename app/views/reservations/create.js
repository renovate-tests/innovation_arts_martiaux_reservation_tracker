// Locate the <tbody> in the HTML
let tableBody = document.querySelector('tbody#reservations')

// Insert the newly-populated `_critter` partial as the first row in the
// table, passing it the @critter value as defined in the controller's
// `create` action
tableBody.insertAdjacentHTML('afterbegin', "<%= escape_javascript(render partial: 'reservations', locals: {reservation: @reservation} ) %>")

// Make the form disappear by setting the placeholder div's content
// to an empty string
document.getElementById("new-form-placeholder").innerHTML = ""