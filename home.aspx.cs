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
        SqlConnection con;
        SqlCommand cmd;

        protected void Page_Load(object sender, EventArgs e)
        {
            getcon();
            productRepeaters();
        }

        void productRepeaters()
        {
            int userId = (Session["UserID"] != null) ? Convert.ToInt32(Session["UserID"]) : -1;

            fillReProd(rptCollection, 4, userId);
            fillReProd(rptWedding, 4, userId);
            fillReProd(rptHoliday, 4, userId);
        }

        void fillReProd(Repeater repeater, int count, int userId)
        {
            DataTable dt = new DataTable();
            string query = "select top " + count + " p.product_id, p.product_name, p.description, p.price, p.old_price, p.stock_quantity, " +
                "p.image_url, p.badge, p.rating_count, case when w.user_id is not null then 1 else 0 end as isinwishlist from Products p left join " +
                "Wishlist w on p.product_id = w.product_id and w.user_id = " + userId + " where p.stock_quantity > 0 order by p.product_id desc";

            SqlDataAdapter sda = new SqlDataAdapter(query, con);
            sda.Fill(dt);

            repeater.DataSource = dt;
            repeater.DataBind();
        }

        protected void product_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int productId = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "ViewProduct")
            {
                Response.Redirect("product-details.aspx?id=" + productId);
                return;
            }

            if (Session["UserID"] == null)
            {
                Response.Redirect("login_register.aspx");
                return;
            }

            int userId = Convert.ToInt32(Session["UserID"]);

            if (e.CommandName == "AddToCart")
            {
                getcon();
                cmd = new SqlCommand("select stock_quantity from Products where product_id = " + productId, con);
                if ((int)cmd.ExecuteScalar() <= 0)
                {
                    Response.Write("<script>alert('Sorry, this product is out of stock!');</script>");
                    return;
                }

                cmd = new SqlCommand("select 1 from Cart where user_id = " + userId + " and product_id = " + productId, con);
                if (cmd.ExecuteScalar() != null)
                {
                    Response.Write("<script>alert('This product is already in your cart.');</script>");
                }
                else
                {
                    cmd = new SqlCommand("insert into Cart (user_id, product_id, quantity) values (" + userId + ", " + productId + ", 1)", con);
                    cmd.ExecuteNonQuery();
                    Response.Write("<script>alert('Product added to cart!');</script>");
                }
                con.Close();
            }
            else if (e.CommandName == "AddToWishlist")
            {
                getcon();
                cmd = new SqlCommand("select 1 from Wishlist where user_id = " + userId + " and product_id = " + productId, con);
                if (cmd.ExecuteScalar() != null)
                {
                    cmd = new SqlCommand("delete from Wishlist where user_id = " + userId + " and product_id = " + productId, con);
                    cmd.ExecuteNonQuery();
                    Response.Write("<script>alert('Product removed from wishlist.');</script>");
                }
                else
                {
                    cmd = new SqlCommand("insert into Wishlist (user_id, product_id) values (" + userId + ", " + productId + ")", con);
                    cmd.ExecuteNonQuery();
                    Response.Write("<script>alert('Product added to wishlist!');</script>");
                }
                productRepeaters();
            }
        }


        void getcon()
        {
            con = new SqlConnection(connect);
            con.Open();
        }
    }
}