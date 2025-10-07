using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Runtime.Remoting.Contexts;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace JenStore
{
    public partial class single_detail1 : System.Web.UI.Page
    {
        string con_str = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;
        


        protected void Page_Load(object sender, EventArgs e)
        {
            getCon();

            if (!IsPostBack)
            {
                fillViewProDL();
                fillRelProDL();
            }
        }

        void getCon()
        {
            con = new SqlConnection(con_str);
            con.Open();
        }

        // view product datalist fill
        void fillViewProDL()
        {
            if (Request.QueryString["id"] == null)
            {
                Response.Redirect("shopping.aspx");
                return;
            }

            int productId = Convert.ToInt32(Request.QueryString["id"]);
            int userId = (Session["UserID"] != null) ? Convert.ToInt32(Session["UserID"]) : -1;

            string query = "select p.product_id, p.product_name, p.description, p.price, p.old_price, p.stock_quantity, p.image_url," +
                           " p.badge, p.rating_count, case when w.user_id is not null then 1 else 0 end as isinwishlist " +
                           "from Products p left join Wishlist w on p.product_id = w.product_id and w.user_id = " + userId +
                           " where p.product_id = " + productId;

            da = new SqlDataAdapter(query, con);
            ds = new DataSet();
            da.Fill(ds);
            dlProductDetails.DataSource = ds;
            dlProductDetails.DataBind();
        }

        
        //Related products datalist fill
        void fillRelProDL()
        {
            int userId =  Convert.ToInt32(Session["UserId"]);

            string query = "select p.product_id, p.product_name, p.description, p.price, p.old_price, p.stock_quantity, p.image_url," +
                           " p.badge, p.rating_count, case when w.user_id is not null then 1 else 0 end as isinwishlist " +
                           "from Products p left join Wishlist w on p.product_id = w.product_id and w.user_id = " + userId;

            da = new SqlDataAdapter(query, con);
            ds = new DataSet();
            da.Fill(ds);
            //dlRelatedProducts.RepeatColumns = 4;
            //dlRelatedProducts.RepeatDirection = (RepeatDirection)HorizontalAlign.Right;
            dlRelatedProducts.RepeatColumns = 4;
            dlRelatedProducts.RepeatDirection = RepeatDirection.Horizontal;
            dlRelatedProducts.DataSource = ds;
            dlRelatedProducts.DataBind();
        }



        //commands of view product
        protected void prDetails_Command(object source, DataListCommandEventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("login_register.aspx");
                return;
            }

            int userId = Convert.ToInt32(Session["UserID"]);
            int productId = Convert.ToInt32(e.CommandArgument);


            TextBox txtQuantity = (TextBox)e.Item.FindControl("txtQuantity");
            int quantity = Convert.ToInt32(txtQuantity.Text);

            if (e.CommandName == "AddToCart")
            {
                cmd = new SqlCommand("select stock_quantity from Products where product_id = " + productId, con);
                if ((int)cmd.ExecuteScalar() <= 0)
                {
                    Response.Write("<script>alert('Sorry, this product is out of stock!');</script>");
                    return;
                }

                cmd = new SqlCommand("select 1 from Cart where user_id = " + userId + " and product_id = " + productId, con);
                if (cmd.ExecuteScalar() != null)
                {
                    Response.Write("<script>alert('Product is already in your cart.');</script>");
                }
                else
                {
                    cmd = new SqlCommand("insert into Cart (user_id, product_id, quantity) values (" + userId + ", " + productId + ", " + quantity + ")", con);
                    cmd.ExecuteNonQuery();
                    Response.Write("<script>alert('Product added to cart!');</script>");
                }
            }
            else if (e.CommandName == "AddToWishlist")
            {
                cmd = new SqlCommand("select 1 from Wishlist where user_id = " + userId + " and product_id = " + productId, con);
                if (cmd.ExecuteScalar() != null)
                {
                    cmd = new SqlCommand("delete from Wishlist where user_id = " + userId + " and product_id = " + productId, con);
                    cmd.ExecuteNonQuery();
                    Response.Write("<script>alert('Product removed from wishlist!');</script>");
                }
                else
                {
                    cmd = new SqlCommand("insert into Wishlist (user_id, product_id) values (" + userId + ", " + productId + ")", con);
                    cmd.ExecuteNonQuery();
                    Response.Write("<script>alert('Product added to wishlist!');</script>");
                }
                fillViewProDL();
                fillRelProDL();
            }
        }

        protected void relProCommand(object source, DataListCommandEventArgs e)
        {
            //store product id
            int productId = Convert.ToInt32(e.CommandArgument);
            if (e.CommandName == "ViewProduct")
            {
                Response.Redirect("product-details.aspx?id=" + productId);
            }

            // check for user id
            if (Session["UserID"] == null)
            {
                Response.Redirect("login_register.aspx");
                return;
            }

            int userId = Convert.ToInt32(Session["UserID"]);

            if (e.CommandName == "AddToCart")
            {
                cmd = new SqlCommand("select stock_quantity from Products where product_id = " + productId, con);
                if ((int)cmd.ExecuteScalar() <= 0)
                {
                    Response.Write("<script>alert('Sorry, this product is out of stock!');</script>");
                    return;
                }

                cmd = new SqlCommand("select 1 from Cart where user_id = " + userId + " and product_id = " + productId, con);
                if (cmd.ExecuteScalar() != null)
                {
                    Response.Write("<script>alert('Product is already in your cart.');</script>");
                }
                else
                {
                    cmd = new SqlCommand("insert into Cart (user_id, product_id, quantity) values (" + userId + ", " + productId + ", " + 1 + ")", con);
                    cmd.ExecuteNonQuery();
                    Response.Write("<script>alert('Product added to cart!');</script>");
                }
            }
            else if (e.CommandName == "AddToWishlist")
            {
                cmd = new SqlCommand("select 1 from Wishlist where user_id = " + userId + " and product_id = " + productId, con);
                if (cmd.ExecuteScalar() != null)
                {
                    cmd = new SqlCommand("delete from Wishlist where user_id = " + userId + " and product_id = " + productId, con);
                    cmd.ExecuteNonQuery();
                    Response.Write("<script>alert('Product removed from wishlist!');</script>");
                }
                else
                {
                    cmd = new SqlCommand("insert into Wishlist (user_id, product_id) values (" + userId + ", " + productId + ")", con);
                    cmd.ExecuteNonQuery();
                    Response.Write("<script>alert('Product added to wishlist!');</script>");
                }
                fillViewProDL();
                fillRelProDL();
            }
        }
    }
}