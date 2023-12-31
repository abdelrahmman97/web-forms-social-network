using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebForms.SocialNetwork.MasterPages
{
	public partial class SiteHome : System.Web.UI.MasterPage
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