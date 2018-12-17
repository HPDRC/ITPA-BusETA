using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BusEta
{
    public partial class showTrack : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int busId = GetIntParam("bus_id");
            int offset = GetIntParam("offset");
            int count = GetIntParam("count");
            List<Track> tracks = Database.GetAllTracks(offset, count, busId);
            foreach (Track track in tracks)
            {
                TableRow row = new TableRow();
                TableCell id = new TableCell();
                TableCell bus_id = new TableCell();
                TableCell lat = new TableCell();
                TableCell lon = new TableCell();
                TableCell bus_time = new TableCell();
                TableCell server_time = new TableCell();
                id.Text = track.id.ToString();
                bus_id.Text = track.bus_id.ToString();
                lat.Text = track.coordinate.Latitude.ToString("F6");
                lon.Text = track.coordinate.Longitude.ToString("F6");
                bus_time.Text = track.busDateTime.ToString("yyyy-MM-dd HH:mm:ss");
                server_time.Text = track.serverDateTime.ToString("yyyy-MM-dd HH:mm:ss");
                row.Cells.Add(id);
                row.Cells.Add(bus_id);
                row.Cells.Add(lat);
                row.Cells.Add(lon);
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