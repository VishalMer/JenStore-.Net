using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Data.SqlClient;

namespace JenStore
{
    public partial class Shopping1 : System.Web.UI.Page
    {
        string connect = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindProductRepeater();
            }
        }

        private void BindProductRepeater()
        {

            using (SqlConnection con = new SqlConnection(connect))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT * FROM Products", con))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        rptProducts.DataSource = dt;
                        rptProducts.DataBind();
                    }
                }
            }
        }

        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("login_register.aspx");
                return;
            }

            int userId = Convert.ToInt32(Session["UserID"]);

            LinkButton btn = (LinkButton)sender;
            int productId = Convert.ToInt32(btn.CommandArgument);

            AddItemToCart(userId, productId);

            // Optional: You can add a message to the user here.
            // For example: ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Product added to cart!');", true);
        }

        private void AddItemToCart(int userId, int productId)
        {
            using (SqlConnection con = new SqlConnection(connect))
            {
                con.Open();
                // Check if the product already exists in the user's cart
                SqlCommand checkCmd = new SqlCommand("SELECT quantity FROM Cart WHERE user_id = @user_id AND product_id = @product_id", con);
                checkCmd.Parameters.AddWithValue("@user_id", userId);
                checkCmd.Parameters.AddWithValue("@product_id", productId);

                object result = checkCmd.ExecuteScalar();

                if (result != null)
                {
                    // If it exists, update the quantity
                    int newQuantity = Convert.ToInt32(result) + 1;
                    SqlCommand updateCmd = new SqlCommand("UPDATE Cart SET quantity = @quantity WHERE user_id = @user_id AND product_id = @product_id", con);
                    updateCmd.Parameters.AddWithValue("@quantity", newQuantity);
                    updateCmd.Parameters.AddWithValue("@user_id", userId);
                    updateCmd.Parameters.AddWithValue("@product_id", productId);
                    updateCmd.ExecuteNonQuery();
                }
                else
                {
                    // If it does not exist, insert a new record
                    SqlCommand insertCmd = new SqlCommand("INSERT INTO Cart (user_id, product_id, quantity) VALUES (@user_id, @product_id, 1)", con);
                    insertCmd.Parameters.AddWithValue("@user_id", userId);
                    insertCmd.Parameters.AddWithValue("@product_id", productId);
                    insertCmd.ExecuteNonQuery();
                }
            }
        }
    }
}
