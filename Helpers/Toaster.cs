using System;
using System.Web.UI;

namespace WebForms.SocialNetwork.Helpers
{
	public class Toaster
	{
		public static void Create( Page page, Type instanceType, string type, string message )
		{
			page.ClientScript.RegisterStartupScript
				(
				instanceType,
				"ShowToast",
				$"showToast('{message}', '{type}');",
				true
				);

		}
	}
}