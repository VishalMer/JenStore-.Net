using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JenStore
{
    public partial class home1 : System.Web.UI.Page
    {
        string connect = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindProductRepeaters();
            }
        }

        private void BindProductRepeaters()
        {
            rptCollection.DataSource = GetRandomProducts(4);
            rptCollection.DataBind();

            rptWedding.DataSource = GetRandomProducts(4);
            rptWedding.DataBind();

            rptHoliday.DataSource = GetRandomProducts(4);
            rptHoliday.DataBind();
        }

        private DataTable GetRandomProducts(int count)
        {
            DataTable dt = new DataTable();
            using (SqlConnection con = new SqlConnection(connect))
            {
                string query = "select top (@count) * from Products order by newid()";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@count", count);
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        sda.Fill(dt);
                    }
                }
            }
            return dt;
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
        }

        protected void btnAddToWishlist_Click(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("login_register.aspx");
                return;
            }
            int userId = Convert.ToInt32(Session["UserID"]);
            LinkButton btn = (LinkButton)sender;
            int productId = Convert.ToInt32(btn.CommandArgument);
            ToggleWishlistItem(userId, productId);
        }

        private void AddItemToCart(int userId, int productId)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connect))
                {
                    con.Open();
                    SqlCommand stockCmd = new SqlCommand("select stock_quantity from Products where product_id = @product_id", con);
                    stockCmd.Parameters.AddWithValue("@product_id", productId);
                    if ((int)stockCmd.ExecuteScalar() <= 0)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Sorry, this product is out of stock!');", true);
                        return;
                    }
                    SqlCommand checkCmd = new SqlCommand("select 1 from Cart where user_id = @user_id and product_id = @product_id", con);
                    checkCmd.Parameters.AddWithValue("@user_id", userId);
                    checkCmd.Parameters.AddWithValue("@product_id", productId);
                    if (checkCmd.ExecuteScalar() != null)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('This product is already in your cart.');", true);
                    }
                    else
                    {
                        SqlCommand insertCmd = new SqlCommand("insert into Cart (user_id, product_id, quantity) values (@user_id, @product_id, 1)", con);
                        insertCmd.Parameters.AddWithValue("@user_id", userId);
                        insertCmd.Parameters.AddWithValue("@product_id", productId);
                        insertCmd.ExecuteNonQuery();
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Product added to cart!');", true);
                    }
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Error: " + ex.Message.Replace("'", "\\'") + "');", true);
            }
        }

        private void ToggleWishlistItem(int userId, int productId)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connect))
                {
                    con.Open();
                    SqlCommand checkCmd = new SqlCommand("select 1 from Wishlist where user_id = @user_id and product_id = @product_id", con);
                    checkCmd.Parameters.AddWithValue("@user_id", userId);
                    checkCmd.Parameters.AddWithValue("@product_id", productId);

                    if (checkCmd.ExecuteScalar() != null)
                    {
                        SqlCommand deleteCmd = new SqlCommand("delete from Wishlist where user_id = @user_id and product_id = @product_id", con);
                        deleteCmd.Parameters.AddWithValue("@user_id", userId);
                        deleteCmd.Parameters.AddWithValue("@product_id", productId);
                        deleteCmd.ExecuteNonQuery();
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Product removed from wishlist.');", true);
                    }
                    else
                    {
                        SqlCommand insertCmd = new SqlCommand("insert into Wishlist (user_id, product_id) values (@user_id, @product_id)", con);
                        insertCmd.Parameters.AddWithValue("@user_id", userId);
                        insertCmd.Parameters.AddWithValue("@product_id", productId);
                        insertCmd.ExecuteNonQuery();
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Product added to wishlist!');", true);
                    }
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Error: " + ex.Message.Replace("'", "\\'") + "');", true);
            }
        }
    }
}

