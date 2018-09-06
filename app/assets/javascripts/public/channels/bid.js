$(document).ready(function() {
  view = document.querySelector("#auction_id");
  if (view) {
    App.bid = App.cable.subscriptions.create(
      {
        channel: "BidChannel",
        auction_id: view.dataset.auctionId
      },
      {
        conntected: function() {
        },
        disconnected: function() {
        },
        received: function(data) {
          load_bid(data);  
        }
      }
    );
  }
  else {
    if (App.bid !== undefined) {
      App.bid.unsubscribe()
      // delete(App.auction);
    }
  }
});

function load_bid(data) {
  data = data.list;
  html = ''
  data.forEach(function(e){
    html += '<tr>'
    html += '<td>' + e['name'] + '</td>'
    html += '<td>' + e['amount'] + '</td>'
    html += '<td>' + e['created_at'] + '</td>'
    html += '</tr>'
  });
  $("#bids_history tbody").html(html);
}
