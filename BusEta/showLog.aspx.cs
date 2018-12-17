using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BusEta
{
    public partial class showLog : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int busId = GetIntParam("bus_id");
            int offset = GetIntParam("offset");
            int count = GetIntParam("count");
            List<Log> logs = Database.GetAllLogs(offset, count, busId);
            foreach (Log log in logs)
            {
                TableRow row = new TableRow();
                TableCell id = new TableCell();
                TableCell bus_id = new TableCell();
                TableCell message = new TableCell();
                TableCell bus_time = new TableCell();
                TableCell server_time = new TableCell();
                id.Text = log.id.ToString();
                bus_id.Text = log.bus_id.ToString();
                message.Text = log.message.ToString();
                bus_time.Text = log.busDateTime.ToString("yyyy-MM-dd HH:mm:ss");
                server_time.Text = log.serverDateTime.ToString("yyyy-MM-dd HH:mm:ss");
                row.Cells.Add(id);
                row.Cells.Add(bus_id);
                row.Cells.Add(message);
                row.Cells.Add(bus_time);
                row.Cells.Add(server_time);
                logList.Rows.Add(row);
            }
        }

        private int GetIntParam(string paramId)
        {
            return Request[paramId] == null ? 0 : int.Parse(Request[paramId]);
        }
    }
}