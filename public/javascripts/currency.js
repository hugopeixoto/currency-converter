var currencies = {};

function add_currency(name, value) { currencies[name] = value; }

function update_fields() {
  var from = $('from').value;
  var from_rate = currencies[from];
  var amount = $('from_amount').value;

  $$('ul.to li.currency').each(function(e) {
    var field = e.select('span')[0];
    var to_rate = currencies[field.id];
    e.select('span')[0].update(amount * to_rate / from_rate);
  });
}

function select_from(evt, e) {
  $('from').value = e.select('h3')[0].innerHTML;
  update_fields();
}

Event.observe(window, 'load', function()
{
  Event.observe('from_amount', 'keyup', update_fields);

  $$('ul.from li.currency').each(function (e)
  {
    Event.observe(e, 'click', function(elem) { return function (evt) { return select_from(evt, elem); } }(e));
  });
});
