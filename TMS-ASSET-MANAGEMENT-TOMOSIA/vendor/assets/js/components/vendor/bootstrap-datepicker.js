'use strict';

var Datepicker = (function() {
	var $datepicker = $('.datepicker');
	function init($this) {
		var options = {
			disableTouchKeyboard: true,
			autoclose: false
		};

		$this.datepicker(options);
	}
	if ($datepicker.length) {
		$datepicker.each(function() {
			init($(this));
		});
	}
})();
