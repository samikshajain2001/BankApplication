using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BankApplication.Admin
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                loadDataFomDB();
            }
        }

        private void loadDataFomDB()
        {
            string CS = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;
            using (SqlConnection con = new SqlConnection(CS))
            {
                SqlDataAdapter da = new SqlDataAdapter("spGetClient", con);
                da.SelectCommand.CommandType = System.Data.CommandType.StoredProcedure;

                DataSet ds = new DataSet();
                da.Fill(ds, "Clients");

                ds.Tables["Clients"].PrimaryKey = new DataColumn[] { ds.Tables["Clients"].Columns["ClientID"] };

                gvLoadData.DataSource = ds;
                gvLoadData.DataBind();
            }

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            String cs = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                string checkUserQuery = "SELECT COUNT(*) FROM Clients Where UserName = @UserName";
                SqlCommand checkcmd = new SqlCommand(checkUserQuery, con);
                checkcmd.Parameters.AddWithValue("@UserName", txtUserName.Text.Trim());

                int userCount = (int)checkcmd.ExecuteScalar();

                if(userCount > 0 && txtUserName.Text.Trim()!="")
                {
                    lblExist.Text = "UserName already Exist. Please choose a different UserName.";
                    lblExist.ForeColor = System.Drawing.Color.Red;
                }

                else
                {
                    SqlCommand cmd = new SqlCommand("spAddClient", con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@UserName", txtUserName.Text.Trim());
                    cmd.Parameters.AddWithValue("@Password", txtPassword.Text.Trim());
                    cmd.Parameters.AddWithValue("@FirstName", txtFirstName.Text.Trim());
                    cmd.Parameters.AddWithValue("@LastName", txtLastName.Text.Trim());
                    cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                    cmd.Parameters.AddWithValue("@Phone", txtPhone.Text.Trim());
                    cmd.Parameters.AddWithValue("@Address", txtAddress.Text.Trim());


                    cmd.ExecuteNonQuery();

                    lblSuccess.Text = "Client added successfully!!";
                    lblSuccess.ForeColor = System.Drawing.Color.Blue;
                    clear();
                    form.Visible = false;
                    loadDataFomDB();
                }
            }

        }

        protected void btnAddClient_Click(object sender, EventArgs e)
        {
            lblExist.Text = "";
            lblSuccess.Text = "";
            if (form.Visible == false)
            {
                form.Visible = true;
            }
            else
            {
                form.Visible = false;
            }
        }

        protected void clear()
        {
            txtUserName.Text = "";
            txtPassword.Text = "";
            txtFirstName.Text = "";
            txtFirstName.Text = "";
            txtLastName.Text = "";
            txtEmail.Text = "";
            txtPhone.Text = "";
            txtAddress.Text = "";
        }

        protected void gvLoadData_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvLoadData.EditIndex = e.NewEditIndex;
            loadDataFomDB();
        }

        protected void gvLoadData_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string CS = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;
            using (SqlConnection con = new SqlConnection(CS))
            {
                SqlCommand cmd = new SqlCommand("spDeleteClient", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@ClientID", e.Keys["ClientID"]);

                con.Open();
                cmd.ExecuteNonQuery();
            }
            loadDataFomDB();
        }

        protected void gvLoadData_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            string CS = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;
            using (SqlConnection con = new SqlConnection(CS))
            {

                SqlCommand cmd = new SqlCommand("spUpdateClient", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@ClientID", e.Keys["ClientID"]);
                cmd.Parameters.AddWithValue("@FirstName", e.NewValues["Name"]);
                cmd.Parameters.AddWithValue("@Email", e.NewValues["Email"]);
                cmd.Parameters.AddWithValue("@Phone", e.NewValues["Phone"]);
                cmd.Parameters.AddWithValue("@Address", e.NewValues["Address"]);

                con.Open();
                cmd.ExecuteNonQuery();

            }

            gvLoadData.EditIndex = -1;
            loadDataFomDB();
        }

        protected void gvLoadData_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvLoadData.EditIndex = -1;
            loadDataFomDB();
        }
    }
}