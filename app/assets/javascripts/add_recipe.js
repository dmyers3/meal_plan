$('.ingredient_container').on('click', function(e) {
  if (e.target.closest('.add_ingredient')) {
    addIngredient(e)
  } else if (e.target.closest('.delete_ingredient')) {
    deleteIngredient(e)
  }
});

$('#new_recipe').on('submit', function(e) {
  e.preventDefault();
  disableSubmitButton();
  removeErrors();
  if (validInput()) {
    this.submit();
  } else {
    enableSubmitButton();
  }
});

function addIngredient(e) {
  e.preventDefault();
  var ingredientInput = $('.ingredient_input').first().clone();
  var newIngredient = ingredientInput.insertAfter($('.ingredient_input').last());
  clearIngredientValues(newIngredient);
}

function deleteIngredient(e) {
  e.preventDefault();
  var clicked_item = e.target.closest('.ingredient_input');
  if ($('.ingredient_input').size() !== 1) {
    clicked_item.remove();
  } else {
    clearIngredientValues(clicked_item);
  }
}

function clearIngredientValues(ingredient) {
  $(ingredient).closest('.ingredient_input').find('input, select').each(function(index, obj) {
    $(obj).val('');
  });
}

function removeErrors() {
  $('.has-error').each(function(index, element) {
    $(element).removeClass('has-error');
  });
  
  $('.help-block').each(function(index, element) {
    $(element).remove();
  });
}

function validInput() {
  var valid = true
  $('.quantity, .unit, .ingredient_name, .recipe_name').each(function(index, element) {
    if ($(element).find('input').val() === "" || $(element).find('select').val() === null) {
      $(element).append("<span class=help-block>can't be blank</span>");
      $(element).addClass("has-error");
      valid = false
    }
  });
  return valid
}

function disableSubmitButton() {
  $('input[type="submit"]').prop('disabled', true);
}

function enableSubmitButton() {
  $('input[type="submit"]').prop('disabled', false);
}
