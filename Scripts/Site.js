function showToast( message, messageType )
{
	toastr.options = {
		closeButton: true,
		progressBar: true,
		positionClass: 'toast-top-right',
		preventDuplicates: false,
		showDuration: 400,
		hideDuration: 1000,
		timeOut: 7000,
		extendedTimeOut: 1000,
		showEasing: 'swing',
		hideEasing: 'linear',
		showMethod: 'fadeIn',
		hideMethod: 'fadeOut'
	};

	toastr[ messageType ]( message );
}
