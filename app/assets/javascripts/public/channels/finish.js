$(document).ready(function() {
  fview = document.querySelector("#auction_id");
  if (fview) {
    App.finish = App.cable.subscriptions.create(
      {
        channel: 'FinishChannel',
        auction_id: fview.dataset.auctionId
      },
      {
        received: function(data) {
          show_alert(data.obj);
        }
      }
    );
  }
 });

function show_alert(data) {
  user_id = $("#current_user").data('user-id');
  if (user_id === data) {
    swal({
      title: "Chúc mừng",
      text: "Bạn đã đấu giá thành công sản phẩm",
      icon: "success",
      time: 3000,
    })
  }
}
