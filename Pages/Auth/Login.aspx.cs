using System;
using System.Collections.Generic;
using System.Data;
using System.Web.UI;
using WebForms.SocialNetwork.Helpers;

namespace WebForms.SocialNetwork.Pages.Auth
{
	public partial class Login : System.Web.UI.Page
	{
		private ConnectDB ConnectDB = new ConnectDB( "db_SocialNetwork" );

		protected void Page_Load( object sender, EventArgs e )
		{
			if ( !IsPostBack )
			{
				if ( Session[ "Username" ] != null )
				{
					Response.Redirect( GetRouteUrl( "/", null ) );
				}
			}
		}

		private bool ValidateLoginForm()
		{
			IList<string> errors = new List<string>();
			if ( string.IsNullOrWhiteSpace( textBox_Email.Text ) ) errors.Add( "Email is not valid!" );
			if ( string.IsNullOrWhiteSpace( textBox_Password.Text ) ) errors.Add( "Password is not valid!" );

			if ( errors.Count > 0 )
			{
				Toaster.Create( Page, this.GetType(), "error", string.Join( "<br>", errors ) );
			}

			return errors.Count == 0;
		}

		protected void Btn_SignIn_Click( object sender, EventArgs e )
		{
			if ( !ValidateLoginForm() ) return;

			DataTable result = ConnectDB.ExecuteQuery( $"SELECT Email, PasswordHash, Username, UserID FROM Users WHERE Email = '{textBox_Email.Text}'" );

			if ( result.Rows.Count == 0 )
			{
				Toaster.Create( Page, this.GetType(), "error", "User is not exist or Email is wrong<br>Please try agin" );
				return;
			}

			bool isPasswordCorrect = BCrypt.Net.BCrypt.Verify( textBox_Password.Text, result.Rows[ 0 ][ "PasswordHash" ].ToString() );

			if ( isPasswordCorrect )
			{
				Session[ "Username" ] = result.Rows[ 0 ][ "Username" ].ToString();
				Session[ "UserID" ] = result.Rows[ 0 ][ "UserID" ].ToString();
				Response.Redirect( GetRouteUrl( "/", null ) );
			}
			else
			{
				Toaster.Create( Page, this.GetType(), "error", "Password is wrong<br>Please try agin" );
			}

		}

	}
}