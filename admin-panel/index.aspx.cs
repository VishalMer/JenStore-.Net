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
            getcon();

            if (Session["UserID"] == null)
            {
                Response.Redirect("../login_register.aspx");
                return;
            }

            if (Session["UserRole"].ToString().ToLower() != "admin" )
            {
                Response.Redirect("../home.aspx");
                return;
            }

            if (!IsPostBack)
            {
                DisplayStats();
                WelcomeMessage();
                BindRecentOrders();
            }
        }

        void WelcomeMessage()
        {
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

        }
        void DisplayStats()
        {
            cmd = new SqlCommand("select sum(total_amount) from orders where order_status = 'delivered'", con);
            object totalSales = cmd.ExecuteScalar();
            if (totalSales != DBNull.Value)
            {
                lblTotalSales.Text = Convert.ToDecimal(totalSales).ToString("C0");
            }
            else
            {
                lblTotalSales.Text = "$0";
            }

            cmd = new SqlCommand("SELECT SUM(total_amount) FROM orders WHERE order_status = 'delivered' AND MONTH(order_date) = MONTH(GETDATE()) AND YEAR(order_date) = YEAR(GETDATE())", con);
            object monthlySales = cmd.ExecuteScalar();
            if (monthlySales != DBNull.Value)
            {
                lblMonthlyToatal.Text = Convert.ToDecimal(monthlySales).ToString("C0");
            }
            else
            {
                lblMonthlyToatal.Text = "$0";
            }

            cmd = new SqlCommand("select count(*) from orders", con);
            lblTotalOrders.Text = cmd.ExecuteScalar().ToString();

            cmd = new SqlCommand("select count(*) from users where role != 'admin'", con); 
            lblTotalCustomers.Text = cmd.ExecuteScalar().ToString();
        }

        private void BindRecentOrders()
        {
            string query = "SELECT TOP 5 o.order_id, u.uname as Username, o.total_amount, o.order_status FROM orders o INNER JOIN users u ON o.user_id = u.Id ORDER BY o.order_date DESC";
            SqlDataAdapter da = new SqlDataAdapter(query, con);
            DataSet ds = new DataSet();
            da.Fill(ds);

            gvRecentOrders.DataSource = ds;
            gvRecentOrders.DataBind();
        }

        public string GetStatusCssClass(object status)
        {
            string statusClass = "order-status ";
            switch (status.ToString().ToLower())
            {
                case "pending":
                    statusClass += "status-pending";
                    break;
                case "processing":
                    statusClass += "status-processing";
                    break;
                case "shipped":
                    statusClass += "status-shipped";
                    break;
                case "delivered":
                    statusClass += "status-delivered";
                    break;
                case "cancelled":
                    statusClass += "status-cancelled";
                    break;
                default:
                    statusClass += "status-pending";
                    break;
            }
            return statusClass;
        }

        void getcon()
        {
            con = new SqlConnection(connect);
            con.Open();
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("../login_register.aspx");
        }
    }
}