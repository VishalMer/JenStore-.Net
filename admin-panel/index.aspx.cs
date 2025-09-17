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

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DisplayStats();
            }
        }

        private void DisplayStats()
        {
            getcon();

            cmd = new SqlCommand("select sum(total_amount) from Orders where order_status = 'Completed'", con);
            object totalSales = cmd.ExecuteScalar();
            if (totalSales != DBNull.Value)
            {
                lblTotalSales.Text = Convert.ToDecimal(totalSales).ToString("C0");
            }
            else
            {
                lblTotalSales.Text = "$0";
            }

            // Get Total Orders
            cmd = new SqlCommand("select count(*) from Orders", con);
            lblTotalOrders.Text = cmd.ExecuteScalar().ToString();

            // Get Total Customers
            cmd = new SqlCommand("select count(*) from users", con);
            lblTotalCustomers.Text = cmd.ExecuteScalar().ToString();

            // Get This Month's Revenue
            DateTime firstDayOfMonth = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
            DateTime firstDayOfNextMonth = firstDayOfMonth.AddMonths(1);

            cmd = new SqlCommand("select sum(total_amount) from Orders where order_status = 'Completed' and order_date >= '" + firstDayOfMonth.ToString("yyyy-MM-dd") + "' and order_date < '" + firstDayOfNextMonth.ToString("yyyy-MM-dd") + "'", con);
            object monthlyRevenueResult = cmd.ExecuteScalar();
            if (monthlyRevenueResult != DBNull.Value)
            {
                lblMonthlyRevenue.Text = Convert.ToDecimal(monthlyRevenueResult).ToString("C0");
            }
            else
            {
                lblMonthlyRevenue.Text = "$0";
            }

            con.Close();
        }

        void getcon()
        {
            con = new SqlConnection(connect);
            con.Open();
        }
    }
}