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
                LoadStats();
                BindFeedback();
            }
        }

        void getcon()
        {
            con = new SqlConnection(con_str);
            con.Open();
        }

        void LoadStats()
        {
            // Total Feedback
            cmd = new SqlCommand("select count(*) from feedback", con);
            lblTotalFeedback.Text = cmd.ExecuteScalar().ToString();

            // New Feedback
            cmd = new SqlCommand("select count(*) from feedback_management where status = 'new'", con);
            lblNewFeedback.Text = cmd.ExecuteScalar().ToString();

            // Replied Feedback
            cmd = new SqlCommand("select count(*) from feedback_management where status = 'replied'", con);
            lblRepliedFeedback.Text = cmd.ExecuteScalar().ToString();

            // Read Feedback
            cmd = new SqlCommand("select count(*) from feedback_management where status = 'read' or status = 'replied'", con);
            lblReadFeedback.Text = cmd.ExecuteScalar().ToString();
        }

        void BindFeedback()
        {
            // Using lowercase query as requested
            string query = @"
                select 
                    f.feedback_id, 
                    f.message, 
                    f.feedback_date, 
                    u.uname, 
                    u.email, 
                    coalesce(fm.status, 'new') as status 
                from feedback f 
                inner join users u on f.user_id = u.id 
                left join feedback_management fm on f.feedback_id = fm.feedback_id 
                order by f.feedback_date desc";

            da = new SqlDataAdapter(query, con);
            ds = new DataSet();
            da.Fill(ds);

            dlFeedback.DataSource = ds;
            dlFeedback.DataBind();
        }

        protected void dlFeedback_ItemCommand(object source, DataListCommandEventArgs e)
        {
            string feedbackId = e.CommandArgument.ToString();
            string adminId = Session["admin_id"]?.ToString() ?? "null";

            if (e.CommandName == "MarkRead")
            {
                // Update status to 'read' or insert if not exists
                string updateQuery = @"
                    if exists (select 1 from feedback_management where feedback_id = " + feedbackId + @")
                        update feedback_management set status = 'read', last_updated = getdate() where feedback_id = " + feedbackId + @"
                    else
                        insert into feedback_management (feedback_id, admin_id, status) values (" + feedbackId + ", " + adminId + ", 'read')";

                cmd = new SqlCommand(updateQuery, con);
                cmd.ExecuteNonQuery();
            }
            else if (e.CommandName == "DeleteFeedback")
            {
                cmd = new SqlCommand("delete from feedback_management where feedback_id = " + feedbackId, con);
                cmd.ExecuteNonQuery();
                cmd = new SqlCommand("delete from feedback where feedback_id = " + feedbackId, con);
                cmd.ExecuteNonQuery();
            }
            // Note: The "Reply" command is now handled by client-side JavaScript

            LoadStats();
            BindFeedback();
        }

        // ADDED: Event handler for the modal's "Send Reply" button
        protected void btnSendReply_Click(object sender, EventArgs e)
        {
            string feedbackId = hdnReplyFeedbackId.Value;
            string replyMessage = txtReplyMessage.Text.Replace("'", "''"); // Basic sanitation
            string adminId = Session["admin_id"]?.ToString() ?? "null";

            if (string.IsNullOrEmpty(feedbackId) || string.IsNullOrEmpty(replyMessage))
            {
                // Optionally show an error message
                return;
            }

            // Update or insert into feedback_management table
            string updateQuery = @"
                if exists (select 1 from feedback_management where feedback_id = " + feedbackId + @")
                    update feedback_management set status = 'replied', reply_message = '" + replyMessage + @"', admin_id = " + adminId + @", last_updated = getdate() where feedback_id = " + feedbackId + @"
                else
                    insert into feedback_management (feedback_id, admin_id, status, reply_message) values (" + feedbackId + ", " + adminId + ", 'replied', '" + replyMessage + @"')";

            cmd = new SqlCommand(updateQuery, con);
            cmd.ExecuteNonQuery();

            // Hide the modal using JavaScript after successful save
            ScriptManager.RegisterStartupScript(this, this.GetType(), "CloseReplyModal", "$('#replyModal').modal('hide');", true);

            // Refresh data
            LoadStats();
            BindFeedback();
        }

        // Helper function for CSS status class
        public string GetStatusClass(object status)
        {
            string statusClass = "feedback-status ";
            switch (status.ToString().ToLower())
            {
                case "new": statusClass += "status-new"; break;
                case "read": statusClass += "status-read"; break;
                case "replied": statusClass += "status-replied"; break;
                case "resolved": statusClass += "status-resolved"; break; // Added 'resolved'
                default: statusClass += "status-new"; break;
            }
            return statusClass;
        }
    }
}