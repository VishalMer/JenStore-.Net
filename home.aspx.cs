using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services.Description;
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

        /// <summary>
        /// This method now calls the database separately for each product section.
        /// </summary>
        private void BindProductRepeaters()
        {
            // Get 4 random products for the "Collection" section
            rptCollection.DataSource = GetRandomProducts(4);
            rptCollection.DataBind();

            // Get 4 new random products for the "Wedding" section
            rptWedding.DataSource = GetRandomProducts(4);
            rptWedding.DataBind();

            // Get 4 new random products for the "Holiday" section
            rptHoliday.DataSource = GetRandomProducts(4);
            rptHoliday.DataBind();
        }

        /// <summary>
        /// A reusable method to fetch a specified number of random products from the database.
        /// </summary>
        private DataTable GetRandomProducts(int count)
        {
            DataTable dt = new DataTable();
            using (SqlConnection con = new SqlConnection(connect))
            {
                // "ORDER BY NEWID()" is the SQL Server command to get random rows.
                // "TOP (@count)" limits the result to the number you specify.
                string query = "SELECT TOP (@count) * FROM Products ORDER BY NEWID()";
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

        // You would also add your AddToCart/AddToWishlist click handlers here
        // if you want those buttons to be functional on the home page.
    }
}

