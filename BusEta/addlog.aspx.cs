using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BusEta
{
    public partial class addlog : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int error = 0;
            string message = "";
            try
            {
                error = 1;
                message = "Cannot parse parameters: ";
                int bus_id = int.Parse(Request["bus_id"]);
                string bus_message = Request["message"];
                Int64 bus_time = Int64.Parse(Request["bus_time"]);

                error = 2;
                Database.AddLog(bus_id, bus_message, bus_time);

                error = 0;
                message = "success";
            }
            catch (Exception ex)
            {
                message += ex.Message;
            }
            Response.Write("error=" + error + ", message=" + message);
        }
    }
}