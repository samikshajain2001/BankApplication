using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BankApplication.Admin
{
    public partial class Account : System.Web.UI.Page
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
                SqlDataAdapter da = new SqlDataAdapter("spGetAccounts", con);
                da.SelectCommand.CommandType = System.Data.CommandType.StoredProcedure;

                DataSet ds = new DataSet();
                da.Fill(ds, "Accounts");

                ds.Tables["Accounts"].PrimaryKey = new DataColumn[] { ds.Tables["Accounts"].Columns["AccountID"] };

                gvLoadData.DataSource = ds;
                gvLoadData.DataBind();
            }

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            int clientId1 = FindIdByUserName(txtClient1.Text.Trim());
            int clientId2 = 0;

            if (txtClient2.Text.Trim() != "")
            {
                clientId2 = FindIdByUserName(txtClient2.Text.Trim());
            }

            if (clientId1 > 0 && (clientId2 > 0 || txtClient2.Text.Trim() == ""))
            {

                string cs = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;

                using (SqlConnection con = new SqlConnection(cs))
                {
                    SqlCommand cmd = new SqlCommand("spAddAccount", con);
                    cmd.CommandType = CommandType.StoredProcedure;


                    decimal balance = 0;
                    if (txtBalance != null && !string.IsNullOrEmpty(txtBalance.Text.Trim()))
                    {
                        decimal.TryParse(txtBalance.Text.Trim(), out balance);
                    }

                    cmd.Parameters.AddWithValue("@Balance", balance);
                    cmd.Parameters.AddWithValue("@ClientID1", clientId1);
                    cmd.Parameters.AddWithValue("@ClientID2", clientId2 > 0 ? (object)clientId2 : DBNull.Value);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                lblSuccess.Text = "Account added successfully!!";
                lblSuccess.ForeColor = System.Drawing.Color.Blue;
                clear();
                form.Visible = false;
                loadDataFomDB();
            }
            else
            {
                if (clientId1 <= 0)
                {
                    lblClient1Error.Text = "Client not found.";
                    lblClient1Error.ForeColor = Color.Red;
                    lblClient1Error.Visible = true;
                }
                if (clientId2 <= 0 && txtClient2.Text.Trim() != "")
                {
                    lblClient2Error.Text = "Client not found.";
                    lblClient2Error.ForeColor = Color.Red;
                    lblClient2Error.Visible = true;
                }
            }

        }

        protected void clear()
        {
            txtBalance.Text = "";
            txtClient1.Text = "";
            txtClient2.Text = "";
        }

        protected void btnAddAccount_Click(object sender, EventArgs e)
        {
            lblClient1Error.Text = "";
            lblClient2Error.Text = "";
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

        protected void btnSearchClient1_Click(object sender, EventArgs e)
        {
            SearchClient(txtClient1.Text.Trim(), lblClient1Error);
        }

        protected void btnSearchClient2_Click(object sender, EventArgs e)
        {
            SearchClient(txtClient2.Text.Trim(), lblClient2Error);
        }

        private void SearchClient(string clientName, Label errorLabel)
        {
            int ClientId = FindIdByUserName(clientName);

            if (ClientId > 0)
            {
                errorLabel.Text = "Client found.";
                errorLabel.ForeColor = Color.Green;
                errorLabel.Visible = true;
            }
            else
            {
                errorLabel.Text = "Client not found.";
                errorLabel.ForeColor = Color.Red;
                errorLabel.Visible = true;
            }
        }

        private int FindIdByUserName(string clientUserName)
        {
            int ClientId = 0;

            string cs = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("Select ClientId from Clients Where UserName = @clientUserName", con);
                cmd.Parameters.AddWithValue("@clientUserName", clientUserName);

                con.Open();
                object result = cmd.ExecuteScalar();

                if (result != null)
                {
                    ClientId = Convert.ToInt32(result);
                }
            }

            return ClientId;
        }

        protected void gvLoadData_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvLoadData.EditIndex = e.NewEditIndex;
            loadDataFomDB();
        }

        protected void gvLoadData_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            String cs = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("spDeleteAccount", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@AccountID", e.Keys["AccountID"]);

                con.Open();
                cmd.ExecuteNonQuery();
            }
            loadDataFomDB();
        }

        protected void gvLoadData_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            String cs = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;
            decimal previousBalance = 0;

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("SELECT Balance FROM Accounts WHERE AccountID = @AccountID", con);

                cmd.Parameters.AddWithValue("@AccountID", e.Keys["AccountID"]);

                con.Open();
                previousBalance = (decimal)cmd.ExecuteScalar();

            }

            decimal balance = 0;
            bool isValid = e.NewValues["Balance"] != null && decimal.TryParse(e.NewValues["Balance"].ToString(), out balance);
            if (!isValid)
            {
                balance = previousBalance;
            }

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("spUpdateAccount", con);
                cmd.CommandType = CommandType.StoredProcedure;


                cmd.Parameters.AddWithValue("@AccountID", e.Keys["AccountID"]);
                cmd.Parameters.AddWithValue("@Balance", balance);

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