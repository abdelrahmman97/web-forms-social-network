using System;
using System.Collections.Generic;
using System.Data;
using System.Web.UI;
using WebForms.SocialNetwork.Helpers;

namespace WebForms.SocialNetwork.Pages.Auth
{
	public partial class Register : System.Web.UI.Page
	{
		private ConnectDB ConnectDB = new ConnectDB( "db_SocialNetwork" );

		protected void Page_Load( object sender, EventArgs e )
		{
			if ( !IsPostBack )
			{
				if ( Session[ "UserID" ] != null )
				{
					Response.Redirect( GetRouteUrl( "/", null ) );
				}
			}
		}

		protected void Btn_Register_Click( object sender, EventArgs e )
		{
			if ( !ValidateRegisterForm() ) return;

			string hashedPassword = BCrypt.Net.BCrypt.HashPassword( textBox_Password.Text );

			int result = ConnectDB.ExecuteNonQuery(
				$"INSERT INTO Users(Username ,PasswordHash ,Email ,FirstName ,LastName ,DateOfBirth ,RegistrationDate) " +
				$"VALUES( '{textBox_Username.Text}','{hashedPassword}', '{textBox_Email.Text}', " +
				$"'{textBox_FirstName.Text}', '{textBox_LastName.Text}', '{Convert.ToDateTime( textBox_Birthdate.Text )}', '{DateTime.Now}')" );

			if ( result != 0 )
			{
				Page.ClientScript.RegisterStartupScript( this.GetType(), "ShowToast", "showToast('You regsitered successfully<br> You can login now!', 'success');", true );
				Response.Redirect( GetRouteUrl( "Login", null ) );
			}
			else
			{
				Page.ClientScript.RegisterStartupScript( this.GetType(), "ShowToast", "showToast('Falid to register<br>Please try agin', 'error');", true );
			}
		}

		private bool ValidateRegisterForm()
		{
			IList<string> errors = new List<string>();
			if ( string.IsNullOrWhiteSpace( textBox_FirstName.Text ) ) errors.Add( "First Name is not valid!" );
			if ( string.IsNullOrWhiteSpace( textBox_LastName.Text ) ) errors.Add( "Last Name is not valid!" );
			if ( string.IsNullOrWhiteSpace( textBox_Username.Text ) ) errors.Add( "Username is not valid!" );
			if ( string.IsNullOrWhiteSpace( textBox_Email.Text ) ) errors.Add( "Email is not valid!" );
			if ( string.IsNullOrWhiteSpace( textBox_Birthdate.Text ) ) errors.Add( "Birthdate is not valid!" );
			if ( string.IsNullOrWhiteSpace( textBox_Password.Text ) ) errors.Add( "Password is not valid!" );

			if ( IsEmailAlreadyExists( textBox_Email.Text ) ) errors.Add( "Email is used before!" );
			if ( IsUsernameAlreadyExists( textBox_Username.Text ) ) errors.Add( "Username is used before!" );

			if ( errors.Count > 0 )
			{
				Page.ClientScript.RegisterStartupScript( this.GetType(), "ShowToast", $"showToast('{string.Join( "<br>", errors )}', 'error');", true );
			}

			return errors.Count == 0;
		}

		private bool IsEmailAlreadyExists( string email )
		{
			DataTable cehckEmail = ConnectDB.ExecuteQuery( $"SELECT COUNT(*) FROM Users WHERE Email = '{email}'" );
			if ( Convert.ToInt32( cehckEmail.Rows[ 0 ][ 0 ] ) != 0 ) return true;
			return false;
		}

		private bool IsUsernameAlreadyExists( string username )
		{
			DataTable cehckEmail = ConnectDB.ExecuteQuery( $"SELECT COUNT(*) FROM Users WHERE Username = '{username}'" );
			if ( Convert.ToInt32( cehckEmail.Rows[ 0 ][ 0 ] ) != 0 ) return true;
			return false;
		}
	}
}