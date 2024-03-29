'use strict';

var Popover = (function() {
	var $popover = $('[data-toggle="popover"]'),
		$popoverClass = '';
	function init($this) {
		if ($this.data('color')) {
			$popoverClass = 'popover-' + $this.data('color');
		}

		var options = {
			trigger: 'focus',
			template: '<div class="popover ' + $popoverClass + '" role="tooltip"><div class="arrow"></div><h3 class="popover-header"></h3><div class="popover-body"></div></div>'
		};

		$this.popover(options);
	}
	if ($popover.length) {
		$popover.each(function() {
			init($(this));
		});
	}

})();
