App.home = App.cable.subscriptions.create('HomeChannel', {
  conntected: function() {
  },
  disconnected: function() {
  },
  received: function(data) {
    load_all_auction(data)
  }
});

$(document).ready(function() {
  get_home();
  get_category();
});

function load_all_auction(data) {
  html = "";
  list = data.obj;
  if (get_category()) {
    list.forEach(function(e) {
      if (e.product_category == get_category().dataset.categoryId) {
        append_html(e);
      }
    });
    $('#auction_category').html(html);
  } else if (get_home()) {
    list.forEach(function(e) {
      append_html(e);
    });
    $('#list_products').html(html);
  }
}

function get_category() {
  return document.querySelector("#auction_category");
}

function get_home() {
  return document.querySelector("#list_products");
}

function append_html(e) {
  html += '<div class="col-sm-4 product-item">';
  html += '<div class="panel panel-primary">';
  html += '<div class="panel-heading "><a href="/auctions/' + e.id + '">' + e.product_name + '</a></div>';
  html += '<div class="panel-body"><a href="/auctions/' + e.id + '"><img src="' + e.product_pictures[0].image.url + '" alt="' + e.product_name + '" class="img-responsive"></a></div>';
  html += '<div class="panel-footer"><p><span class="time_count">'+ time_convert(e.period) + '</span><span class="pull-right">' + formatMoney(e.product_price) + '</p></div>';
  html += '</div>';
  html += '</div>';
}
