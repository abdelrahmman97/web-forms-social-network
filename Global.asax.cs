using System;
using System.Web;
using System.Web.Optimization;
using System.Web.Routing;

namespace WebForms.SocialNetwork
{
	public class Global : HttpApplication
	{
		void Application_Start( object sender, EventArgs e )
		{
			// Code that runs on application startup
			RegisterRoutes( RouteTable.Routes );
			BundleConfig.RegisterBundles( BundleTable.Bundles );
		}

		void RegisterRoutes( RouteCollection routes )
		{
			routes.MapPageRoute(
				"Login",
				"login",
				"~/Pages/Auth/Login.aspx"
				);
			routes.MapPageRoute(
				"Register",
				"register",
				"~/Pages/Auth/Register.aspx"
				);
			routes.MapPageRoute(
				"/",
				"home",
				"~/Pages/Home.aspx"
				);
			routes.MapPageRoute(
				"Home",
				"home",
				"~/Pages/Home.aspx"
				);
			routes.MapPageRoute(
				"Profile",
				"u/{Username}",
				"~/Pages/User/Profile.aspx"
				);
		}
	}
}