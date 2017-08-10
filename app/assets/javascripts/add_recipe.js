$('.ingredient_container').on('click', function(e) {
  if (e.target.closest('.add_ingredient')) {
    addIngredient(e)
  } else if (e.target.closest('.delete_ingredient')) {
    deleteIngredient(e)
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