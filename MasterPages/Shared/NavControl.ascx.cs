using System;

namespace WebForms.SocialNetwork.MasterPages.Shared
{
	public partial class NavControl : System.Web.UI.UserControl
	{
		protected void Page_Load( object sender, EventArgs e )
		{

		}

		protected void Btn_SignOut_Click( object sender, EventArgs e )
		{
			Session.Clear();
			Response.Redirect( GetRouteUrl( "Login", null ) );
		}
	}
}