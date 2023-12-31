using System;
using System.Data;
using System.Web.UI.WebControls;
using WebForms.SocialNetwork.Helpers;

namespace WebForms.SocialNetwork.Pages.HomeComponents
{
	public partial class ToFollowSuggestion : System.Web.UI.UserControl
	{
		private ConnectDB ConnectDB = new ConnectDB( "db_SocialNetwork" );

		protected void Page_Load( object sender, EventArgs e )
		{
			if ( !IsPostBack )
			{
				GetRandomUsers();
			}
		}

		private void GetRandomUsers()
		{
			int loggedInUserID = GetLoggedInUserID();
			string query =
				"SELECT TOP 3 * " +
				"FROM ( " +
				"		SELECT *, ROW_NUMBER() OVER (ORDER BY NEWID()) as rn " +
				"		FROM Users " +
				"		WHERE UserID != " + GetLoggedInUserID() + " AND UserID Not IN (SELECT Friendships.Followed FROM Friendships WHERE Friendships.Follower = " + GetLoggedInUserID() + ") " +
				"	  ) AS sub " +
				"ORDER BY rn;";
			DataTable data = ConnectDB.ExecuteQuery( query );
			rptUsersSuggestion.DataSource = data;
			rptUsersSuggestion.DataBind();
		}

		private int GetLoggedInUserID()
		{
			return Convert.ToInt32( Session[ "UserID" ] );
		}

		protected void rptUsersSuggestion_ItemCommand( object source, RepeaterCommandEventArgs e )
		{
			if ( e.CommandName == "AddFriend" )
			{
				int friendUserId = Convert.ToInt32( e.CommandArgument );
				int currentUserId = GetLoggedInUserID();

				CreateFriendship( currentUserId, friendUserId );

				GetRandomUsers();
			}
		}

		private void CreateFriendship( int currentUserId, int friendUserId )
		{
			// Check if the friendship already exists
			if ( !FriendshipExists( currentUserId, friendUserId ) )
			{
				// Insert a new friendship record
				InsertFriendship( currentUserId, friendUserId );
			}
			else
			{
				DeleteFriendship( currentUserId, friendUserId );
			}
		}

		private bool FriendshipExists( int follower, int followed )
		{
			// Check if a friendship record already exists
			string query = $"SELECT COUNT(*) FROM Friendships WHERE Follower = {follower} AND Followed = {followed}";

			int count = ConnectDB.ExecuteNonQuery( query );
			return count > 0;
		}

		private void InsertFriendship( int follower, int followed )
		{
			// Insert a new friendship record
			string insertQuery = $"INSERT INTO Friendships (Follower, Followed) VALUES ({follower}, {followed})";
			int count = ConnectDB.ExecuteNonQuery( insertQuery );
			if ( count == 1 )
			{
				Toaster.Create( Page, this.GetType(), "succes", "You are now following this user" );
			}
		}

		private void DeleteFriendship( int currentUserId, int friendUserId )
		{
			string query = $"delete from Friendships where Follower = {currentUserId} and Followed = {friendUserId}";
			int count = ConnectDB.ExecuteNonQuery( query );
			if ( count == 1 )
			{
				Toaster.Create( Page, this.GetType(), "succes", "You are not following this user" );
			}
		}

	}
}