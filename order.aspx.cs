using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;
using CrystalDecisions.Shared;
using CrystalDecisions.CrystalReports.Engine;
//using CrystalDecisions.Shared;
using CrystalDecisions.Web;


namespace JenStore
{
    public partial class order1 : System.Web.UI.Page
    {
        string connect = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter da;
        DataSet ds;

        private CrystalDecisions.CrystalReports.Engine.ReportDocument cr = new ReportDocument();
        static string path = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            getcon();

            if (Session["UserID"] == null)
            {
                Response.Redirect("login_register.aspx");
                return;
            }

            if (!IsPostBack)
            {
                fillOrderDL();
            }
        }

        void fillOrderDL()
        {
            int userId = Convert.ToInt32(Session["UserID"]);
            int latestOrderId = 0;

            cmd = new SqlCommand("select top 1 order_id from Orders where user_id = " + userId + " order by order_id desc", con);
            object result = cmd.ExecuteScalar();

            if (result == null || result == DBNull.Value)
            {
                orderDetailsContainer.Visible = false;
                return;
            }

            latestOrderId = Convert.ToInt32(result);

            decimal grandTotal = 0;
            SqlDataAdapter da = new SqlDataAdapter("select order_date, order_status, payment_method, shipping_address, total_amount from Orders where order_id = " + latestOrderId, con);

            DataSet ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                lblOrderID.Text = "#ORD-" + latestOrderId;
                lblOrderDate.Text = Convert.ToDateTime(ds.Tables[0].Rows[0][0]).ToString("MMMM dd, yyyy");
                lblOrderStatus.Text = ds.Tables[0].Rows[0][1].ToString();
                lblPaymentMethod.Text = ds.Tables[0].Rows[0][2].ToString();
                lblShippingAddress.Text = ds.Tables[0].Rows[0][3].ToString().Replace(", ", "<br />");
                grandTotal = Convert.ToDecimal(ds.Tables[0].Rows[0][4]);
            }

            // Fetch the items from order details
            SqlDataAdapter sda = new SqlDataAdapter("select od.quantity, od.price_at_purchase, p.product_name, p.image_url from OrderDetails od inner join Products p on od.product_id = p.product_id where od.order_id = " + latestOrderId, con);

            DataTable dtItems = new DataTable();
            sda.Fill(dtItems);

            dlOrderItems.DataSource = dtItems;
            dlOrderItems.DataBind();

            // Calculate totals
            decimal subTotal = 0;
            foreach (DataRow row in dtItems.Rows)
            {
                subTotal += Convert.ToDecimal(row["price_at_purchase"]) * Convert.ToInt32(row["quantity"]);
            }
            decimal shippingFee = grandTotal - subTotal;

            // Display totals
            lblSubTotal.Text = subTotal.ToString("C");
            lblShipping.Text = shippingFee.ToString("C");
            lblGrandTotal.Text = grandTotal.ToString("C");

        }

        protected void btnDownloadInvoice_Click(object sender, EventArgs e)
        {
            getcon();
            da = new SqlDataAdapter("select * from orders", con);
            ds = new DataSet();
            da.Fill(ds);
            string xml = "D:/WorkSpaces/DotNet/JenStore/orders.xml";

            ds.WriteXmlSchema(xml);

            path = Server.MapPath("orders_rpt.rpt");
            cr.Load(path);
            cr.SetDataSource(ds);
            cr.Database.Tables[0].SetDataSource(ds);
            cr.Refresh();
            CrystalReportViewer1.ReportSource = cr;
            cr.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, true, "Orders");
        }

        void getcon()
        {
            con = new SqlConnection(connect);
            con.Open();
        }
    }
}