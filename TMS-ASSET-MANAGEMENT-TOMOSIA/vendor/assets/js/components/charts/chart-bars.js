var BarsChart = (function() {
	var $chart = $('#chart-bars');
	function initChart($chart) {

		var ordersChart = new Chart($chart, {
			type: 'bar',
			data: {
				labels: ['Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
				datasets: [{
					label: 'Sales',
					data: [25, 20, 30, 22, 17, 29]
				}]
			}
		});

		$chart.data('chart', ordersChart);
	}
	if ($chart.length) {
		initChart($chart);
	}

})();
