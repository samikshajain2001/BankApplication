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
    public partial class AllTransaction : System.Web.UI.Page
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
                SqlDataAdapter da = new SqlDataAdapter("spGetTransactionData", con);
                da.SelectCommand.CommandType = System.Data.CommandType.StoredProcedure;

                DataSet ds = new DataSet();
                da.Fill(ds, "Transactions");

                ds.Tables["Transactions"].PrimaryKey = new DataColumn[] { ds.Tables["Transactions"].Columns["TransactionID"] };

                gvLoadData.DataSource = ds;
                gvLoadData.DataBind();
            }
        }
    }
}