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
    public partial class orders1 : System.Web.UI.Page
    {
        string con_str = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;

        protected void Page_Load(object sender, EventArgs e)
        {
            getcon();
            if (Session["UserID"] == null)
            {
                Response.Redirect("../login_register.aspx");
                return;
            }

            if (Session["UserRole"].ToString().ToLower() != "admin")
            {
                Response.Redirect("../home.aspx");
            }
            if (!IsPostBack)
            {
                BindOrders();
            }
        }

        void getcon()
        {
            
                con = new SqlConnection(con_str);
                con.Open();
            
        }

        void BindOrders()
        {
            string query = "select o.order_id, o.user_id, o.order_date, o.total_amount, o.order_status, u.uname, u.email, " +
                "(select count(distinct od.product_id) from orderdetails od where od.order_id = o.order_id) as product_count, " +
                "(select sum(od.quantity) from orderdetails od where od.order_id = o.order_id) as total_quantity from orders o inner join users u " +
                "on o.user_id = u.id order by o.order_date desc";

            da = new SqlDataAdapter(query, con);
            ds = new DataSet();
            da.Fill(ds);

            gvOrders.DataSource = ds;
            gvOrders.DataBind();
        }

        public string GetStatusClass(object statusObj)
        {
            string status = statusObj.ToString().ToLower();
            switch (status)
            {
                case "pending":
                    return "status-pending";
                case "processing":
                    return "status-processing";
                case "shipped":
                    return "status-shipped";
                case "delivered":
                    return "status-delivered";
                case "cancelled":
                    return "status-cancelled";
                case "completed":
                    return "status-completed";
                default:
                    return "status-pending";
            }
        }

        protected void gvOrders_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string orderId = e.CommandArgument.ToString();

            if (e.CommandName == "ViewOrder")
            {
                Response.Redirect("order-details.aspx?id=" + orderId);
            }
            else if (e.CommandName == "UpdateStatus")
            {
                //i'll add popup to update status later
            }
        }
    }
}