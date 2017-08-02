$('#payment-form').on('submit', function(e) {
});

// $('.bronze').on('click', function(e) {
//   $(this).find('input[type=radio]').attr('checked', 'checked');
// });

// $('.silver').on('click', function(e) {
//   $(this).find('input[type=radio]').attr('checked', 'checked');
// });

// $('.gold').on('click', function(e) {
//   $(this).find('input[type=radio]').attr('checked', 'checked');
// });

$('.plans').on('click', function(e) {
  $plan = clickedPlan(e);
  if ($plan) {
    selectRadioButton($plan);
    unhighlightOldPlan();
    highlightNewPlan($plan);
  }
});

function clickedPlan(e) {
  return $(e.target).closest('.plan');
}

function selectRadioButton(plan) {
  plan.find('input[type=radio]').prop('checked', true);
}

function unhighlightOldPlan() {
  $('.highlight').toggleClass('highlight');
}

function highlightNewPlan(plan) {
  plan.toggleClass('highlight');
}



// Reenable submit button
// $('input[type="submit"]').each(function(index, value) {
//   $(this).prop('disabled', false);
// });