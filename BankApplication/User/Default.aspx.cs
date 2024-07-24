using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BankApplication.User
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["user"] != null)
                {
                    LoadClientData();
                    LoadAccountData();
                }
                else
                {
                    Response.Redirect("~/LoginPage.aspx");
                }
            }
        }


        private void LoadClientData()
        {
            String cs = System.Configuration.ConfigurationManager.ConnectionStrings["cs"].ConnectionString;
            string userId = Session["userId"].ToString();

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT FirstName, LastName FROM Clients WHERE ClientID = @UserId";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@UserId", userId);

                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    string firstName = reader["FirstName"].ToString();
                    string lastName = reader["LastName"].ToString();
                    lblClientName.Text = $"{firstName} {lastName}";
                }
            }
        }

        private void LoadAccountData()
        {
            string cs = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;
            string userId = Session["userId"].ToString();

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("spGetAccountsByClientID", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@ClientID", userId);

                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                DataTable dt = new DataTable();
                dt.Load(reader);

                gvAccounts.DataSource = dt;
                gvAccounts.DataBind();
            }
        }

    }
}