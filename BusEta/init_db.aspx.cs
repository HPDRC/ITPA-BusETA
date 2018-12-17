using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BusEta
{
    public partial class initialize_db : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request["password"] == null || Request["password"] != Config.init_db_password)
            {
                result.Text = "Missing or wrong password!";
                return;
            }

            try
            {
                List<Stop> stops = Database.GetAllStops();
                foreach (Stop thisStop in stops)
                {
                    Stop nextStop = null;
                    for (int i=0; i<stops.Count; i++)
                    {
                        if (stops[i].id == thisStop.next_stop_id)
                        {
                            nextStop = stops[i];
                            break;
                        }
                    }
                    if (nextStop != null)
                    {
                        thisStop.next_stop_distance = thisStop.coordinate.GetDistanceTo(nextStop.coordinate);
                        thisStop.next_stop_time_avg = (int)(thisStop.next_stop_distance / 3.0); // assume bus moves at a speed of 3.0 meters / second
                        Database.UpdateStopInit(thisStop);
                    }
                }
                result.Text = "stops table is successfully initialized! Restart application pool to clear cache!";
            }
            catch (Exception ex)
            {
                result.Text = "Exception: " + ex.Message;
            }
        }

        private void CalcNextStopDistance()
        {

        }
    }
}