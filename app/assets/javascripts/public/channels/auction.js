$(document).ready(function() {
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
          swal("Mất kết nối đến server", "Vui lòng kiểm tra lại đường truyền mạng", "error");
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
  bid(view.dataset.auctionId);
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
  reset_bid_history(data['period']);
}

function bid(auction_id) {
  $('#bid_btn').on('click', function(){
    user_id = get_top_bider_id(auction_id);
  });
}

function reset_bid_history(period) {
  if (period == 0) {
    $("#bids_history tbody").html("");
  }
}

function get_top_bider_id(auction_id){
  var data = { auction_id: auction_id }
  $.ajax({
    url: '/top_bider',
    type: 'GET',
    contentType: 'application/json; charset=utf-8',
    dataType: 'JSON',
    data: data,
    success: function (response) {
      uid = $("#current_user").data('user-id');
      if (uid === response) {
        swal({
          title: "Warning",
          text: "Bạn đang là người giữ giá cao nhất",
          icon: "warning",
          time: 3000,
        })
      } else {
        bid_data = {
          amount: $("#bid_amount").val(),
          user_id: uid,
        }
        App.auction.send(bid_data);
      }
    },
    error: function (err) {
      console.log(err);
    }
  });
}
