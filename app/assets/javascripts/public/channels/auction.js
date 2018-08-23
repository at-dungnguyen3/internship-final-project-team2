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
  bid();
});

function load_auction(data) {
  data = data.obj;
  $("#product_name").html(data['product_name']);
  $("#auction_period").html(time_convert(data['period']));
  $("#auction_price").html(formatMoney(data['product_price']));
  $("#product_description").html(data['product_description']);
  $("#product_detail").html(data['product_detail']);
  $("#bid_amount").attr({
    value: data['product_price'] + data['bid_step'],
    min: data['product_price'] + data['bid_step'],
    step: data['bid_step']
  });
}

function bid() {
  $('#bid_btn').on('click', function(){
    data = {
      amount: $("#bid_amount").val(),
      user_id: $("#current_user").data('user-id')
    }
  App.auction.send(data);
  });
}
