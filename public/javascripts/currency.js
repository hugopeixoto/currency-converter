var currencies = {};

function add_currency(name, value) { currencies[name] = value; }

function update_fields() {
  var from = $('from').innerHTML;
  var from_rate = currencies[from];
  var amount = $('from_amount').value;

  if (!amount.match(/^[0-9]*(\.[0-9]*)?$/))
    return false;

  var to = $('to').innerHTML;
  var to_rate = currencies[to];
  $('to_amount').innerHTML = (amount * to_rate / from_rate).toFixed(2);

  window.location.hash = from + ":" + to + ":" + amount;

  $$('ul.to li.currency').each(function(e) {
    var field = e.select('span')[0];
    var to_rate = currencies[field.id];
    e.select('span')[0].update((amount * to_rate / from_rate).toFixed(2));
  });
}

function select_from(evt, e) {
  $('from').innerHTML = e.select('span.currency')[0].innerHTML;
  $$('ul.from li.currency').each(function(e) { e.removeClassName('selected'); });
  $(e).addClassName('selected');
  update_fields();
}

function select_to(evt, e) {
  $('to').innerHTML = e.select('span.currency')[0].innerHTML;
  $$('ul.to li.currency').each(function(e) { e.removeClassName('selected'); });
  $(e).addClassName('selected');
  update_fields();
}

Event.observe(window, 'load', function()
{
  var parts = window.location.hash.substring(1).split(':');
  if (parts.length > 0 && parts[0].length > 0) select_from(null, $$('ul.from li.currency.' + parts[0])[0]);
  if (parts.length > 1 && parts[1].length > 0) select_to(null, $$('ul.to li.currency.' + parts[1])[0]);
  if (parts.length > 2 && parts[2].length > 0) $('from_amount').value = parts[2];

  update_fields();

  $('from_amount').focus();
  Event.observe('from_amount', 'keyup', update_fields);

  $$('ul.to li.currency').each(function (e) { Event.observe(e, 'click', function(elem) { return function (evt) { return select_to(evt, elem); } }(e)); });
  $$('ul.from li.currency').each(function (e) { Event.observe(e, 'click', function(elem) { return function (evt) { return select_from(evt, elem); } }(e)); });
});
