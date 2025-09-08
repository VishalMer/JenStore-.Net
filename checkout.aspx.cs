using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JenStore
{
    public partial class checkout1 : System.Web.UI.Page
    {
        string connect = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserID"] == null)
                {
                    Response.Redirect("login_register.aspx");
                    return;
                }
                BindOrderSummary();
            }
        }

        /// <summary>
        /// Fetches in-stock cart items and calculates totals to display on the page.
        /// </summary>
        private void BindOrderSummary()
        {
            int userId = Convert.ToInt32(Session["UserID"]);
            decimal subTotal = 0;
            decimal shippingCost = 0; // Default shipping to 0

            using (SqlConnection con = new SqlConnection(connect))
            {
                // This query gets only IN-STOCK items from the cart
                const string query = @"
                    SELECT C.quantity, P.product_name, P.price 
                    FROM Cart C
                    INNER JOIN Products P ON C.product_id = P.product_id
                    WHERE C.user_id = @user_id AND P.stock_quantity > 0";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@user_id", userId);
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);

                        if (dt.Rows.Count == 0)
                        {
                            Response.Write("<script>alert('Your cart is empty.'); window.location='shopping-cart.aspx';</script>");
                            return;
                        }

                        rptOrderSummary.DataSource = dt;
                        rptOrderSummary.DataBind();

                        // Calculate subtotal from the fetched data
                        foreach (DataRow row in dt.Rows)
                        {
                            subTotal += Convert.ToDecimal(row["price"]) * Convert.ToInt32(row["quantity"]);
                        }
                    }
                }
            }

            // Apply shipping cost only if subtotal is > 0 and less than 500
            if (subTotal > 0 && subTotal < 500)
            {
                shippingCost = 40;
            }

            decimal grandTotal = subTotal + shippingCost;

            // Update the labels on the .aspx page
            lblSubTotal.Text = subTotal.ToString("C");
            lblShipping.Text = shippingCost.ToString("C");
            lblOrderTotal.Text = grandTotal.ToString("C");
        }
    }
}