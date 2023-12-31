class TimeUtils
{
	static fromNow( date )
	{
		function calculateRelativeTime()
		{
			const now = new Date();
			const millisecondsAgo = now - date;

			// Define time intervals in milliseconds
			const minute = 60 * 1000;
			const hour = 60 * minute;
			const day = 24 * hour;
			const week = 7 * day;
			const month = 30.44 * day; // Approximate value for a month
			const year = 365.25 * day; // Approximate value for a year

			if ( millisecondsAgo < minute )
			{
				return 'Just now';
			}
			else if ( millisecondsAgo < hour )
			{
				const minutes = Math.floor( millisecondsAgo / minute );
				return `${ minutes } minute${ minutes > 1 ? 's' : '' } ago`;
			}
			else if ( millisecondsAgo < day )
			{
				const hours = Math.floor( millisecondsAgo / hour );
				return `${ hours } hour${ hours > 1 ? 's' : '' } ago`;
			}
			else if ( millisecondsAgo < week )
			{
				const days = Math.floor( millisecondsAgo / day );
				return `${ days } day${ days > 1 ? 's' : '' } ago`;
			}
			else if ( millisecondsAgo < month )
			{
				const weeks = Math.floor( millisecondsAgo / week );
				return `${ weeks } week${ weeks > 1 ? 's' : '' } ago`;
			}
			else if ( millisecondsAgo < year )
			{
				const months = Math.floor( millisecondsAgo / month );
				return `${ months } month${ months > 1 ? 's' : '' } ago`;
			}
			else
			{
				const years = Math.floor( millisecondsAgo / year );
				return `${ years } year${ years > 1 ? 's' : '' } ago`;
			}
		}

		// Initial calculation
		let result = calculateRelativeTime();

		// Update every minute
		setInterval( () =>
		{
			result = calculateRelativeTime();
		}, 60 * 1000 );

		return result;
	}
}

