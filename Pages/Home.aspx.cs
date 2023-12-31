using System;
using System.Data;
using WebForms.SocialNetwork.Helpers;

namespace WebForms.SocialNetwork.Pages
{
	public partial class Home : System.Web.UI.Page
	{
		private ConnectDB ConnectDB = new ConnectDB( "db_SocialNetwork" );

		protected void Page_Load( object sender, EventArgs e )
		{
			if ( !IsPostBack )
			{
				if ( Session[ "UserID" ] != null )
				{
					BindPostData();
				}
				else
				{
					Response.Redirect( GetRouteUrl( "Login", null ) );
				}
			}
		}

		private void BindPostData()
		{
			int loggedInUserID = GetLoggedInUserID();

			string query =
				$" SELECT " +
				$"    Posts.PostID, " +
				$"    Posts.UserID, " +
				$"    Posts.Content, " +
				$"    Posts.PostDate, " +
				$"    Users.Username, " +
				$"    Users.FirstName, " +
				$"    Users.LastName, " +
				$"    (SELECT COUNT(*) FROM PostLikes WHERE PostLikes.PostID = Posts.PostID) AS LikesCount " +
				$" FROM Posts " +
				$" INNER JOIN Users ON Posts.UserID = Users.UserID " +
				$" WHERE Posts.UserID = {loggedInUserID} " +
				$" OR Posts.UserID IN (SELECT Friendships.Followed FROM Friendships WHERE Friendships.Follower = {loggedInUserID})";


			DataTable data = ConnectDB.ExecuteQuery( query );
			rptPosts.DataSource = data;
			rptPosts.DataBind();

		}

		protected void Btn_Post_Click( object sender, EventArgs e )
		{
			if ( !string.IsNullOrWhiteSpace( textBox_Post.Text ) )
			{
				string query = $"INSERT INTO POSTS(UserID, Content, PostDate) VALUES({GetLoggedInUserID()},N'{textBox_Post.Text.Trim()}', '{DateTime.Now}')";
				int result = ConnectDB.ExecuteNonQuery( query );
				if ( result == 1 )
				{
					Toaster.Create( Page, this.GetType(), "success", "Post created successfully" );
					textBox_Post.Text = string.Empty;
					BindPostData();
				}
				else
				{
					Toaster.Create( Page, this.GetType(), "error", "Falid to create post" );
				}
			}
			else
			{
				Toaster.Create( Page, this.GetType(), "error", "Post conetent can not be empty" );
			}
		}

		private int GetLoggedInUserID()
		{
			return Convert.ToInt32( Session[ "UserID" ] );
		}

		protected string DisplayPostDropdownOptions( object userIdObj )
		{
			if ( userIdObj != null && Session[ "UserID" ] != null )
			{
				if ( Convert.ToInt32( userIdObj ) != Convert.ToInt32( Session[ "UserID" ] ) )
				{
					return @"
					<li><a class='dropdown-item' href='#'><i class='bi bi-bookmark fa-fw pe-2'></i>Save post</a></li>
					<li><a class='dropdown-item' href='#'><i class='bi bi-person-x fa-fw pe-2'></i>Unfollow lori ferguson </a></li>
					<li><a class='dropdown-item' href='#'><i class='bi bi-x-circle fa-fw pe-2'></i>Hide post</a></li>
					<li><a class='dropdown-item' href='#'><i class='bi bi-slash-circle fa-fw pe-2'></i>Block</a></li>
					<li>
						<hr class='dropdown-divider'>
					</li>
					<li><a class='dropdown-item' href='#'><i class='bi bi-flag fa-fw pe-2'></i>Report post</a></li>";
				}
				return @"
					<li><a class='dropdown-item' href='#'><i class='bi bi-bookmark fa-fw pe-2'></i>Edit post</a></li>
					<li><a class='dropdown-item' href='#'><i class='bi bi-x-circle fa-fw pe-2'></i>Delete post</a></li>";
			}
			return "";

		}

	}
}