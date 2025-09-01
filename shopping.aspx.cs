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
    public partial class shopping1 : System.Web.UI.Page
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

    }
}