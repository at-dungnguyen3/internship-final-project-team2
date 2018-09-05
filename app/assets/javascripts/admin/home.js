var chart_data = {
  initOnLoad: function() {
    chart_data.request_users();
  },
  set_data_chart: function(response) {
    var data_users = []
    if(response !== undefined) {
      response.reverse();
      response.forEach(element => {
        data_users.push({ x: new Date(element[0]), y: element[1]});     
      });
    }
    var chart = new CanvasJS.Chart("chartUser", {
      animationEnabled: true,
      title: {
        fontFamily: "Arial",
        text: "Thống kê số lượng đăng ký tài khoản theo ngày trong tuần"
      },
      axisX: {
        title: "Thời gian"
      },
      axisY: {
        title: "Số lượng",
      },
      data: [{
        type: "line",
        name: "Tài khoản",
        connectNullData: true,
        //nullDataLineDashType: "solid",
        xValueType: "dateTime",
        xValueFormatString: "DD MM",
        yValueFormatString: "#",
        dataPoints: data_users
      }]
    });
    chart.render();
  },
  request_users: function(){
    $.ajax({
      url: '/admin/chart_users',
      type: 'GET',
      contentType: 'application/json; charset=utf-8',
      dataType: 'JSON',
      success: function (response) {
        chart_data.set_data_chart(response);
      },
      error: function (err) {
      }
    });
  }
}


var chart_order_data = {
  initOnLoad: function() {
    chart_order_data.request_orders();
  },
  set_data_chart: function(response) {
    var data_orders = []
    if(response !== undefined) {
      response.reverse();
      response.forEach(element => {
        data_orders.push({ x: new Date(element[0]), y: element[1]});     
      });
    }
    var chart = new CanvasJS.Chart("chartOrder", {
      animationEnabled: true,
      title: {
        fontFamily: "Arial",
        text: "Thống kê số lượng đơn hàng được đặt theo ngày trong tuần"
      },
      axisX: {
        title: "Thời gian"
      },
      axisY: {
        title: "Số lượng",
      },
      data: [{
        type: "line",
        name: "Tài khoản",
        connectNullData: true,
        //nullDataLineDashType: "solid",
        xValueType: "dateTime",
        xValueFormatString: "DD MM",
        yValueFormatString: "#",
        dataPoints: data_orders
      }]
    });
    chart.render();
  },
  request_orders: function(){
    $.ajax({
      url: '/admin/chart_orders',
      type: 'GET',
      contentType: 'application/json; charset=utf-8',
      dataType: 'JSON',
      success: function (response) {
        chart_order_data.set_data_chart(response);
      },
      error: function (err) {
      }
    });
  }
}

$(document).ready(function() {
    chart_data.initOnLoad();
    chart_order_data.initOnLoad();
});
