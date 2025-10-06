using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace JenStore.admin_panel
{
    public partial class index1 : System.Web.UI.Page
    {
        string connect = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter da;
        DataSet ds;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("../login_register.aspx");
                return;
            }

            if (!IsPostBack)
            {
                DisplayStats();
                WelcomeMessage();
            }
        }

        private void WelcomeMessage()
        {
            getcon();
            int userId = Convert.ToInt32(Session["UserID"]);

            da = new SqlDataAdapter("select uname, role from users where Id = " + userId, con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                string username = ds.Tables[0].Rows[0][0].ToString();
                string role = ds.Tables[0].Rows[0][1].ToString();

                role = char.ToUpper(role[0]) + role.Substring(1);

                lblWelcomeMessage.Text = "Welcome back, " + username + " (" + role + ")";
            }

            con.Close();
        }
        private void DisplayStats()
        {
            getcon();

            cmd = new SqlCommand("select sum(total_amount) from Orders where order_status = 'Completed'", con);
            object totalSales = cmd.ExecuteScalar();
            if (totalSales != DBNull.Value)
            {
                lblTotalSales.Text = Convert.ToDecimal(totalSales).ToString("C0");
                lblMonthlyToatal.Text = Convert.ToDecimal(totalSales).ToString("C0");
            }
            else
            {
                lblTotalSales.Text = "$0";
                lblMonthlyToatal.Text = "$0";
            }

            cmd = new SqlCommand("select count(*) from Orders", con);
            lblTotalOrders.Text = cmd.ExecuteScalar().ToString();

            cmd = new SqlCommand("select count(*) from users", con);
            lblTotalCustomers.Text = cmd.ExecuteScalar().ToString();


            con.Close();
        }

        void getcon()
        {
            con = new SqlConnection(connect);
            con.Open();
        }
    }
}