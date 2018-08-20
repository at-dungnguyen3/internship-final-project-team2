App.home = App.cable.subscriptions.create('HomeChannel', {
  conntected: function() {
  },
  disconnected: function() {
  },
  received: function(data) {
    html = "";
    list = data.obj;
    list.forEach(function(e) {
      html += '<div class="col-sm-4 product-item">';
      html += '<div class="panel panel-primary">';
      html += '<div class="panel-heading "><a href="#">' + e.product_name + '</a></div>';
      html += '<div class="panel-body"><a href="#"><img src="' + e.product_pictures[0].image.url + '" alt="' + e.product_name + '" class="img-responsive"></a></div>';
      html += '<div class="panel-footer"><p><span class="time_count">'+ time_convert(e.period) + '</span><span class="pull-right">' + e.product_price + '</p></div>';
      html += '</div>';
      html += '</div>';
    });
    $('#list_products').html(html);
  }
});

$(document).on('turbolinks:load', function() {

});

function time_convert(num)
 { 
  var date = new Date(null);
  date.setSeconds(num);
  var result = date.toISOString().substr(11, 8);
  return result;
}
