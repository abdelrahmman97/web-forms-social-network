using System;
using System.Data;
using System.Linq;
using WebForms.SocialNetwork.Helpers;

namespace WebForms.SocialNetwork.Pages.User
{
	public partial class Profile : System.Web.UI.Page
	{
		private readonly ConnectDB ConnectDB = new ConnectDB( "db_SocialNetwork" );

		private string UserID
		{
			get { return ViewState[ "UserID" ] as string; }
			set { ViewState[ "UserID" ] = value; }
		}

		private string Username
		{
			get { return ViewState[ "Username" ] as string; }
			set { ViewState[ "Username" ] = value; }
		}

		protected void Page_Load( object sender, EventArgs e )
		{
			if ( !IsPostBack )
			{
				if ( Session[ "Username" ] == null )
				{
					Response.Redirect( GetRouteUrl( "Login", null ) );
				}
				else
				{
					if ( !string.IsNullOrEmpty( GetUsernameFromUrl() ) )
					{
						BindUserData( GetUsernameFromUrl() );
					}
				}
			}
		}

		private string GetUsernameFromUrl()
		{
			string[] segments = Request.Url.Segments;

			// The last segment in the URL should be the username
			string username = segments.LastOrDefault();

			// Remove any trailing slashes
			if ( !string.IsNullOrEmpty( username ) )
			{
				username = username.TrimEnd( '/' );
			}

			return username;
		}

		private void BindUserData( string username )
		{
			DataTable dataTable = ConnectDB.ExecuteQuery(
				$"SELECT UserID, Username, FirstName, LastName, Email, DateOfBirth, RegistrationDate," +
				$"       Gender, About, Country, Job, Verified, Avatar, Cover " +
				$"FROM Users WHERE Username = '{username}'" );
			if ( dataTable.Rows.Count > 0 )
			{
				Username = dataTable.Rows[ 0 ][ "Username" ].ToString();
				UserID = dataTable.Rows[ 0 ][ "UserID" ].ToString();
				string FirstName = dataTable.Rows[ 0 ][ "FirstName" ].ToString();
				string LastName = dataTable.Rows[ 0 ][ "LastName" ].ToString();
				string Email = dataTable.Rows[ 0 ][ "Email" ].ToString();
				string DateOfBirth = dataTable.Rows[ 0 ][ "DateOfBirth" ].ToString();
				string RegistrationDate = dataTable.Rows[ 0 ][ "RegistrationDate" ].ToString();
				string Gender = dataTable.Rows[ 0 ][ "Gender" ].ToString();
				string About = dataTable.Rows[ 0 ][ "About" ].ToString();
				string Country = dataTable.Rows[ 0 ][ "Country" ].ToString();
				string Job = dataTable.Rows[ 0 ][ "Job" ].ToString();
				string Verified = dataTable.Rows[ 0 ][ "Verified" ].ToString();
				string Avatar = dataTable.Rows[ 0 ][ "Avatar" ].ToString();
				string Cover = dataTable.Rows[ 0 ][ "Cover" ].ToString();

				li_Gender.Visible = !string.IsNullOrEmpty( Gender );
				li_Job.Visible = !string.IsNullOrEmpty( Job );
				li_Country.Visible = !string.IsNullOrEmpty( Country );

				lblFirstName.Text = FirstName;
				lblLastName.Text = LastName;
				lblJob.Text = Job;
				lblCountry.Text = Country;
				lblRegistrationDate.Text = DateTime.Parse( RegistrationDate ).ToString( "MMM dd yyyy" ); ;
				lblAbout.Text = About;
				lblDateOfBirth.Text = DateTime.Parse( DateOfBirth ).ToString( "MMM dd yyyy" );
				lblGender.Text = !string.IsNullOrEmpty( Gender ) ? bool.Parse( Gender ) ? "Male" : "Female" : "";
				lblEmail.Text = Email;
				verifiedIcon.Visible = !string.IsNullOrEmpty( Verified );
				imgCover.Style.Add( "background-image", $"url('{Cover}')" );
				imgAvatar.Src = Avatar;

				Toaster.Create( Page, this.GetType(), "success", "done" );
			}
			else
			{
				Toaster.Create( Page, this.GetType(), "error", "user not found" );
			}
		}

		protected bool ShowFollowButton()
		{
			return Session[ "Username" ].ToString() != Username;
		}

		protected bool CheckFollowStatus()
		{
			string loggedinUserID = Session[ "UserID" ].ToString();
			DataTable result = ConnectDB.ExecuteQuery( $"SELECT COUNT(FollowID) as 'result' FROM Friendships WHERE Follower = {loggedinUserID} AND Followed = {UserID}" );
			if ( result.Rows.Count > 0 )
			{
				return result.Rows[ 0 ][ 0 ].ToString() == "1";
			}
			return false;
		}

		protected void Btn_Follow_Click( object sender, EventArgs e )
		{
			string loggedinUserID = Session[ "UserID" ].ToString();
			string query = $"INSERT INTO Friendships (Follower, Followed) VALUES ({loggedinUserID}, {UserID})";
			int count = ConnectDB.ExecuteNonQuery( query );
			if ( count == 1 )
			{
				Toaster.Create( Page, this.GetType(), "succes", "You are now following this user" );
			}
		}

		protected void Btn_UnFollow_Click( object sender, EventArgs e )
		{
			string loggedinUserID = Session[ "UserID" ].ToString();
			string query = $"delete from Friendships where Follower = {loggedinUserID} and Followed = {UserID}";
			int count = ConnectDB.ExecuteNonQuery( query );
			if ( count == 1 )
			{
				Toaster.Create( Page, this.GetType(), "succes", "You are not following this user" );
			}
		}


	}
}

