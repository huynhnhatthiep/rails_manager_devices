'use strict';

var FormControl = (function() {
	var $input = $('.form-control');
	function init($this) {
		$this.on('focus blur', function(e) {
        $(this).parents('.form-group').toggleClass('focused', (e.type === 'focus'));
    }).trigger('blur');
	}
	if ($input.length) {
		init($input);
	}

})();
