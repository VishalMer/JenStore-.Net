using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;

namespace JenStore.admin_panel
{
    public class ChartData
    {
        public string ChartDate { get; set; }
        public decimal DailyTotal { get; set; }
    }
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
                fillRecentOrders();
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

            cmd = new SqlCommand("select sum(total_amount) from orders where order_status = 'delivered' and month(order_date) = month(GETDATE()) and year(order_date) = year(GETDATE())", con);
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

        private void fillRecentOrders()
        {
            string query = "select TOP 5 o.order_id, u.uname as Username, o.total_amount, o.order_status FROM orders o inner join users u on o.user_id = u.Id order by o.order_date desc";
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

        [WebMethod]
        public static string GetSalesChartData()
        {
            List<ChartData> data = new List<ChartData>();

            string con_str = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;

            string query = "select convert(varchar, cast(order_date as date), 106) as chartdate, sum(total_amount) as dailytotal from orders group by cast(order_date as date) order by cast(order_date as date)";

            using (SqlConnection con = new SqlConnection(con_str))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        data.Add(new ChartData()
                        {
                            ChartDate = reader["chartdate"].ToString(),
                            DailyTotal = Convert.ToDecimal(reader["dailytotal"])
                        });
                    }
                }
            }

            JavaScriptSerializer js = new JavaScriptSerializer();
            return js.Serialize(data);
        }
    }
}
