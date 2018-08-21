$(document).on('turbolinks:load', function() {
  view = document.querySelector("#auction_id");
  if (view) {
    App.auction = App.cable.subscriptions.create(
      {
        channel: "AuctionChannel",
        auction_id: view.dataset.auctionId
      },
      {
        conntected: function() {
        },
        disconnected: function() {
        },
        received: function(data) {
          load_auction(data);  
        }
      }
    );
  }
  else {
    if (App.auction !== undefined) {
      App.auction.unsubscribe()
      // delete(App.auction);
    }
  }
});

function load_auction(data) {
  data = data.obj;
  $("#product_name").html(data['product_name']);
  $("#auction_period").html(time_convert(data['period']));
  $("#auction_price").html(formatMoney(data['product_price']));
  $("#product_description").html(data['product_description']);
  $("#product_detail").html(data['product_detail']);
  $("#bid_amount").attr('value',formatMoney(data['product_price']));
}
