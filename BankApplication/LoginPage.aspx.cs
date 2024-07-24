using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BankApplication
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                string userName = ConfigurationManager.AppSettings["username"];
                string password = ConfigurationManager.AppSettings["password"];
                if (userName == txtUserName.Text.Trim() && password == txtPassword.Text.Trim())
                {
                    Session["admin"] = userName;
                    Response.Redirect("~/Admin/Default.aspx", false);
                }
                else
                {
                    String cs = ConfigurationManager.ConnectionStrings["cs"].ConnectionString;

                    using (SqlConnection con = new SqlConnection(cs))
                    {
                        string query = "SELECT * FROM Clients Where UserName = @UserName and Password = @Password";
                        SqlCommand cmd = new SqlCommand(query, con);

                        cmd.Parameters.AddWithValue("@UserName", txtUserName.Text.Trim());
                        cmd.Parameters.AddWithValue("@Password", txtPassword.Text.Trim());
                        con.Open();
                        SqlDataReader sdr = cmd.ExecuteReader();
                        if (sdr.Read())
                        {
                            Session["user"] = sdr["UserName"].ToString();
                            Session["userId"] = sdr["ClientID"].ToString();
                            Response.Redirect("~/User/Default.aspx", false);
                        }
                        else
                        {
                            lblError.Visible = true;
                            lblError.Text = "Credentials are incorrect..!";
                            lblError.CssClass = " mx-auto alert alert-danger";
                        }
                    }
                }
            }
            catch(Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }

    }
}