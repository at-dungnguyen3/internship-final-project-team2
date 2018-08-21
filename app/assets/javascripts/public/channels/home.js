App.home = App.cable.subscriptions.create('HomeChannel', {
  conntected: function() {
  },
  disconnected: function() {
  },
  received: function(data) {
    load_all_auction(data)
  }
});

$(document).on('turbolinks:load', function() {
});

function load_all_auction(data) {
  html = "";
  list = data.obj;
  list.forEach(function(e) {
    html += '<div class="col-sm-4 product-item">';
    html += '<div class="panel panel-primary">';
    html += '<div class="panel-heading "><a href="/auctions/' + e.id + '">' + e.product_name + '</a></div>';
    html += '<div class="panel-body"><a href="/auctions/' + e.id + '"><img src="' + e.product_pictures[0].image.url + '" alt="' + e.product_name + '" class="img-responsive"></a></div>';
    html += '<div class="panel-footer"><p><span class="time_count">'+ time_convert(e.period) + '</span><span class="pull-right">' + formatMoney(e.product_price) + '</p></div>';
    html += '</div>';
    html += '</div>';
  });
  $('#list_products').html(html);
}
