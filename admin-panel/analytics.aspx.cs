using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JenStore.admin_panel
{
    public class KpiItem
    {
        public string KpiName { get; set; }
        public string KpiValue { get; set; }
    }
    public partial class analytics : System.Web.UI.Page
    {
        string con_str = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter da;
        DataSet ds;

        protected void Page_Load(object sender, EventArgs e)
        {
            getcon();
            // check for admin
            if (Session["UserID"] == null)
            {
                Response.Redirect("../login_register.aspx");
                return;
            }
            if (Session["UserRole"].ToString().ToLower() != "admin")
            {
                Response.Redirect("../home.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadKpiCards();
                BindFunnel();
            }
        }

        void getcon()
        {
            if (con == null || con.State == ConnectionState.Closed)
            {
                con = new SqlConnection(con_str);
                con.Open();
            }
        }

        void LoadKpiCards()
        {
            string dateFilter = "where order_date >= dateadd(day, -30, getdate())";

            // total revenue (last 30 days)
            cmd = new SqlCommand("select sum(total_amount) from orders where order_status = 'delivered' and order_date >= dateadd(day, -30, getdate())", con);
            object totalSales = cmd.ExecuteScalar();
            lblTotalRevenue.Text = (totalSales != DBNull.Value) ? Convert.ToDecimal(totalSales).ToString("C0") : "$0";

            // total orders (last 30 days)
            cmd = new SqlCommand("select count(order_id) from orders " + dateFilter, con);
            lblTotalOrders.Text = cmd.ExecuteScalar().ToString();

            // total customers (new customers in last 30 days)
            cmd = new SqlCommand("select count(id) from users where role = 'customer' and created_at >= dateadd(day, -30, getdate())", con);
            lblTotalCustomers.Text = cmd.ExecuteScalar().ToString();

            // avg order value (last 30 days)
            cmd = new SqlCommand("select avg(total_amount) from orders where order_status = 'delivered' and order_date >= dateadd(day, -30, getdate())", con);
            object avgOrder = cmd.ExecuteScalar();
            lblAvgOrderValue.Text = (avgOrder != DBNull.Value) ? Convert.ToDecimal(avgOrder).ToString("C2") : "$0.00";
        }

        void BindFunnel()
        {
            var funnel = new List<KpiItem>();

            // 1. added to cart (total items in all carts)
            cmd = new SqlCommand("select sum(quantity) from cart", con);
            object cartItems = cmd.ExecuteScalar();
            funnel.Add(new KpiItem { KpiName = "items in cart", KpiValue = (cartItems != DBNull.Value) ? cartItems.ToString() : "0" });

            // 2. added to wishlist
            cmd = new SqlCommand("select count(*) from wishlist", con);
            object wishlistItems = cmd.ExecuteScalar().ToString();
            funnel.Add(new KpiItem { KpiName = "items in wishlist", KpiValue = (wishlistItems != DBNull.Value) ? wishlistItems.ToString() : "0" });

            // 3. purchases
            cmd = new SqlCommand("select count(*) from orders where order_status != 'cancelled'", con);
            object purchases = cmd.ExecuteScalar().ToString();
            funnel.Add(new KpiItem { KpiName = "total purchases", KpiValue = (purchases != DBNull.Value) ? purchases.ToString() : "0" });

            rptFunnel.DataSource = funnel;
            rptFunnel.DataBind();
        }
    }
}