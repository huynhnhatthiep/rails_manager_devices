'use strict';

var CopyIcon = (function() {

	var $element = '.btn-icon-clipboard',
		$btn = $($element);

	function init($this) {
		$this.tooltip().on('mouseleave', function() {
			$this.tooltip('hide');
		});

		var clipboard = new ClipboardJS($element);
		clipboard.on('success', function(e) {
			$(e.trigger)
				.attr('title', 'Copied!')
				.tooltip('_fixTitle')
				.tooltip('show')
				.attr('title', 'Copy to clipboard')
				.tooltip('_fixTitle')

			e.clearSelection()
		});
	}
	if ($btn.length) {
		init($btn);
	}

})();
