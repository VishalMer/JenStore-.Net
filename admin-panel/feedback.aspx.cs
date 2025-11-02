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

namespace JenStore.admin_panel
{
    public partial class feedback1 : System.Web.UI.Page
    {
        string con_str = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;
        PagedDataSource pg;

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
                ViewState["Id"] = 0;
                fillStats();
                fillGVProducts();
            }
        }

        void getcon()
        {
            con = new SqlConnection(con_str);
            con.Open();
        }

        void fillStats()
        {
            cmd = new SqlCommand("select count(*) from feedback", con);
            lblTotalFeedback.Text = cmd.ExecuteScalar().ToString();

            cmd = new SqlCommand("select count(*) from feedback where status = 'new'", con);
            lblNewFeedback.Text = cmd.ExecuteScalar().ToString();

            cmd = new SqlCommand("select count(distinct feedback_id) from notifications where notification_type = 'feedback_reply'", con);
            lblRepliedFeedback.Text = cmd.ExecuteScalar().ToString();

            cmd = new SqlCommand("select count(*) from feedback where status != 'new'", con);
            lblReadFeedback.Text = cmd.ExecuteScalar().ToString();

            cmd = new SqlCommand("select count(*) from feedback where status = 'resolved'", con);
            lblResolvedFeedback.Text = cmd.ExecuteScalar().ToString();
        }

        void fillGVProducts()
        {
            string query = "select f.feedback_id, f.message, f.feedback_date, f.status, u.uname, u.email from feedback f inner join " +
                "users u on f.user_id = u.id order by f.feedback_date desc";

            da = new SqlDataAdapter(query, con);
            ds = new DataSet();
            da.Fill(ds);

            pg = new PagedDataSource();
            pg.DataSource = ds.Tables[0].DefaultView;
            pg.AllowPaging = true;
            pg.PageSize = 4; 
            pg.CurrentPageIndex = Convert.ToInt32(ViewState["Id"]);

            lnkPrev.Enabled = !pg.IsFirstPage;
            lnkNext.Enabled = !pg.IsLastPage;

            var pages = new List<ListItem>();
            for (int i = 0; i < pg.PageCount; i++)
            {
                pages.Add(new ListItem((i + 1).ToString(), i.ToString(), i == pg.CurrentPageIndex));
            }
            rptPager.DataSource = pages;
            rptPager.DataBind();

            dlFeedback.DataSource = pg;
            dlFeedback.DataBind();
        }

        protected void dlFeedback_ItemCommand(object source, DataListCommandEventArgs e)
        {
            string feedbackId = e.CommandArgument.ToString();

            if (e.CommandName == "MarkRead")
            {
                // Update status to 'read'
                string updateQuery = "update feedback set status = 'read' where feedback_id = " + feedbackId;
                cmd = new SqlCommand(updateQuery, con);
                cmd.ExecuteNonQuery();
            }
            else if (e.CommandName == "DeleteFeedback")
            {
                cmd = new SqlCommand("delete from notifications where feedback_id = " + feedbackId, con);
                cmd.ExecuteNonQuery();
                cmd = new SqlCommand("delete from feedback where feedback_id = " + feedbackId, con);
                cmd.ExecuteNonQuery();
            }
            else if (e.CommandName == "MarkResolved")
            {
                // Update status to 'resolved' 
                string updateQuery = "update feedback set status = 'resolved' where feedback_id = " + feedbackId;
                cmd = new SqlCommand(updateQuery, con);
                cmd.ExecuteNonQuery();
            }

            fillStats();
            fillGVProducts();
        }


        protected void btnSendReply_Click(object sender, EventArgs e)
        {
            string feedbackId = hdnReplyFeedbackId.Value;
            string replyMessage = txtReplyMessage.Text.Replace("'", "''"); 

            if (string.IsNullOrEmpty(feedbackId) || string.IsNullOrEmpty(replyMessage))
            {
               // Something Went Wrong!
                return;
            }

            // fetch user id associated with the feedback
            cmd = new SqlCommand("select user_id from feedback where feedback_id = " + feedbackId, con);
            string userid = cmd.ExecuteScalar().ToString();

            string query = "insert into notifications (user_id, feedback_id, message, notification_type) values (" + userid + ", " + feedbackId + ", '" + replyMessage + "', 'feedback_reply')";
            cmd = new SqlCommand(query, con);
            cmd.ExecuteNonQuery();

            // Update feedback status to 'replied'
            cmd = new SqlCommand("update feedback set status = 'replied' where feedback_id = " + feedbackId, con);
            cmd.ExecuteNonQuery();

            ScriptManager.RegisterStartupScript(this, this.GetType(), "CloseReplyModal", "$('#replyModal').modal('hide');", true);

            fillStats();
            fillGVProducts();
        }

        protected void lnkPrev_Click(object sender, EventArgs e)
        {
            int currentPage = Convert.ToInt32(ViewState["Id"]);
            if (currentPage > 0)
            {
                currentPage--;
                ViewState["Id"] = currentPage;
                fillGVProducts();
            }
        }

        protected void lnkNext_Click(object sender, EventArgs e)
        {
            int currentPage = Convert.ToInt32(ViewState["Id"]);
            currentPage++;
            ViewState["Id"] = currentPage;
            fillGVProducts();
        }

        protected void rptPager_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Page")
            {
                ViewState["Id"] = Convert.ToInt32(e.CommandArgument);
                fillGVProducts();
            }
        }

        public string GetStatusClass(object status)
        {
            string statusClass = "feedback-status ";
            switch (status.ToString().ToLower())
            {
                case "new": statusClass += "status-new"; break;
                case "read": statusClass += "status-read"; break;
                case "replied": statusClass += "status-replied"; break;
                case "resolved": statusClass += "status-resolved"; break; 
                default: statusClass += "status-new"; break;
            }
            return statusClass;
        }
    }
}