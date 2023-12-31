using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace WebForms.SocialNetwork.Helpers
{
	public class ConnectDB
	{
		private readonly string _connectionString = "";
		private SqlConnection _connection = new SqlConnection();
		private SqlCommand _command = new SqlCommand();
		private DataTable dt = new DataTable();

		public ConnectDB( string connection )
		{
			_connectionString = ConfigurationManager.ConnectionStrings[ connection ].ConnectionString;
		}

		public void StartConnection()
		{
			_connection.Close();
			_connection.ConnectionString = _connectionString;
			_connection.Open();
			_command.Connection = _connection;
			_command.CommandTimeout = 999999;
		}

		public DataTable ExecuteQuery( string query )
		{
			try
			{
				StartConnection();
				_command.CommandText = query;
				using ( SqlDataAdapter adapter = new SqlDataAdapter( _command ) )
				{
					adapter.Fill( dt );
				}
			}
			finally
			{
				_connection.Close();
			}
			return dt;
		}

		public int ExecuteNonQuery( string query )
		{
			int rowsAffected = 0;
			try
			{
				StartConnection();
				_command.CommandText = query;
				rowsAffected = _command.ExecuteNonQuery();
			}
			finally
			{
				_connection.Close();
			}
			return rowsAffected;
		}
	}
}