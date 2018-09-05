var chart_search_data = {
  initOnLoad: function() {
    chart_search_data.request_orders();
  },
  set_data_chart: function(response) {
    var data_chart = []
    if(response !== undefined) {
      response.forEach(element => {
        data_chart.push({ x: new Date(element[0]), y: element[1]});     
      });
    }
    var chart = new CanvasJS.Chart("chart", {
      animationEnabled: true,
      title: {
        fontFamily: "Arial",
        text: "Bảng thống kê"
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
        dataPoints: data_chart
      }]
    });
    chart.render();
  },
  request_orders: function(){
    var obj = $('#chart').data('search');
    var start_at = $('#chart').data('start_at');
    var end_at = $('#chart').data('end_at');
    $.ajax({
      url: '/admin/chart',
      type: 'GET',
      contentType: 'application/json; charset=utf-8',
      dataType: 'JSON',
      data: {obj: obj, start_at: start_at, end_at: end_at},
      success: function (response) {
        chart_search_data.set_data_chart(response);
      },
      error: function (err) {
      }
    });
  }
}

$(document).ready(function() {
  chart_search_data.initOnLoad();
});
