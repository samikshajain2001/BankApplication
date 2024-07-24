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
    public partial class Transaction : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["user"] != null)
                {
                    loadDataFomDB();
                }
                else
                {
                    Response.Redirect("~/LoginPage.aspx");
                }
            }
        }

        private void loadDataFomDB()
        {
            string clientId = Session["userId"].ToString();

            string CS = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;
            using (SqlConnection con = new SqlConnection(CS))
            {
                SqlCommand cmd = new SqlCommand("spGetTransactionsByClientID", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@ClientID", clientId);

                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                DataTable dt = new DataTable();
                dt.Load(reader);
                
                gvLoadData.DataSource = dt;
                gvLoadData.DataBind();
            }
        }

        protected void btnSubmitTransaction_Click(object sender, EventArgs e)
        {
            lblTransactionError.Text = ".";
            lblTransactionError.Visible = false;

            string accountNumber = txtAccountNumber.Text.Trim();
            decimal amount;
            string transactionType = ddlTransactionType.SelectedValue;
            string targetAccount = txtTargetAccount.Text.Trim();

            bool isTargetAccountValid;
            bool isClientAccountValid = IsAccountValid(accountNumber, targetAccount, out isTargetAccountValid);

            if (!isClientAccountValid)
            {
                lblNumberError.Visible = true;
                lblNumberError.Text = "Invalid Account Number";
                lblNumberError.ForeColor = System.Drawing.Color.Red;
                return;
            }
            else
            {
                lblNumberError.Visible = false;
                lblNumberError.Text = "";
            }

            if (!decimal.TryParse(txtAmount.Text.Trim(), out amount))
            {
                lblAmountError.Visible = true;
                lblAmountError.Text = "Invalid amount";
                lblAmountError.ForeColor = System.Drawing.Color.Red;
                return;
            }
            else
            {
                lblAmountError.Visible = false;
                lblAmountError.Text = "";
            }

            if (transactionType == "Transfer" && !isTargetAccountValid)
            {
                lblTargetNumberError.Visible = true;
                lblTargetNumberError.Text = "Invalid Account Number";
                lblTargetNumberError.ForeColor = System.Drawing.Color.Red;
                return;
            }
            else
            {
                lblTargetNumberError.Visible = false;
                lblTargetNumberError.Text = "";
            }

            performTransaction(accountNumber, amount, transactionType, targetAccount);
            loadDataFomDB();
        }

        protected void ddlTransactionType_SelectedIndexChanged(object sender, EventArgs e)
        {
            lblTransactionError.Visible = false;
            lblTransactionError.Text = "";

            string transactionType = ddlTransactionType.SelectedValue;

            if(transactionType == "Transfer")
            {
                lblTargetAccount.Visible = true;
                txtTargetAccount.Visible = true;
                RequiredFieldValidator2.Visible = true;
            }
            else
            {
                lblTargetAccount.Visible = false;
                txtTargetAccount.Visible = false;
                RequiredFieldValidator2.Visible = false;
            }
        }

        protected bool IsAccountValid(string accountNumber, string targetAccount, out bool isTargetAccountValid)
        {
            string clientId = Session["userId"].ToString();
            isTargetAccountValid = true;

            string cs = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("spIsAccountValid", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@ClientID", clientId);
                cmd.Parameters.AddWithValue("@AccountNumber", accountNumber);
                cmd.Parameters.AddWithValue("@TargetAccount", String.IsNullOrWhiteSpace(targetAccount) ? (object)DBNull.Value : targetAccount);

                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    bool isClientAccountValid = reader.GetBoolean(reader.GetOrdinal("IsClientAccountValid"));
                    isTargetAccountValid = reader.GetBoolean(reader.GetOrdinal("IsTargetAccountValid"));

                    return isClientAccountValid;
                }
            }
            return false;
        }

        protected void performTransaction(string accountNumber, decimal amount, string transactionType, string targetAccount)
        {
            string clientId = Session["userId"].ToString();

            string cs = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("spPerformTransaction", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@ClientID", clientId);
                cmd.Parameters.AddWithValue("@AccountNumber", accountNumber);
                cmd.Parameters.AddWithValue("@Amount", amount);
                cmd.Parameters.AddWithValue("@TransactionType", transactionType);
                cmd.Parameters.AddWithValue("@TargetAccount", String.IsNullOrWhiteSpace(targetAccount) ? (object)DBNull.Value : targetAccount);

                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    lblTransactionError.Text = "Transaction successful.";
                    lblTransactionError.ForeColor = System.Drawing.Color.Blue;
                    lblTransactionError.Visible = true;
                    clear();
                }
                catch(SqlException ex)
                {
                    lblTransactionError.Text = ex.Message;
                    lblTransactionError.ForeColor = System.Drawing.Color.Red;
                    lblTransactionError.Visible = true;
                }
            }
        }

        protected void clear()
        {
            lblNumberError.Visible = false;
            lblNumberError.Text = "";
            lblAmountError.Visible = false;
            lblAmountError.Text = "";
            lblTargetNumberError.Visible = false;
            lblTargetNumberError.Text = "";

            lblTargetAccount.Visible = false;
            txtTargetAccount.Visible = false;
            RequiredFieldValidator2.Visible = false;

            txtAccountNumber.Text = "";
            txtAmount.Text = "";
            ddlTransactionType.SelectedIndex = -1;
            txtTargetAccount.Text = "";
        }

        protected void txtAccountNumber_TextChanged(object sender, EventArgs e)
        {
            lblTransactionError.Visible = false;
            lblTransactionError.Text = "";
        }

        protected void txtAmount_TextChanged(object sender, EventArgs e)
        {
            lblTransactionError.Visible = false;
            lblTransactionError.Text = "";
        }

        protected void txtTargetAccount_TextChanged(object sender, EventArgs e)
        {
            lblTransactionError.Visible = false;
            lblTransactionError.Text = "";
        }
    }
}