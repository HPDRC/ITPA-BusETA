using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;

namespace BusEta
{
    public partial class track : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Clear();
            Response.ContentType = "application/json";
            Response.Write(processInput());
        }

        private string processInput()
        {
            try
            {
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                Track track = null;
                int error = 10, eta = -1;
                string message = "undefined";
                string prevStop = "";
                string prevStop_display = "";
                string prevStop_read = "";
                string nextStop = "";
                string nextStop_display = "";
                string nextStop_read = "";
                bool isAtStop = false;
                try
                {
                    error = 1;
                    message = "Cannot parse parameters: ";
                    track = new Track(Request);

                    error = 2;
                    message = "Cannot calculate extra fields: ";
                    track.CalcFields();

                    isAtStop = track.at_prev_stop;
                    if (track.prev_stop_id != 0 && track.next_stop_id != 0)
                    {
                        prevStop = DbCache.stopDict[track.prev_stop_id].name;
                        prevStop_display = DbCache.stopDict[track.prev_stop_id].display_name;
                        prevStop_read = DbCache.stopDict[track.prev_stop_id].read_name;
                        nextStop = DbCache.stopDict[track.next_stop_id].name;
                        nextStop_display = DbCache.stopDict[track.next_stop_id].display_name;
                        nextStop_read = DbCache.stopDict[track.next_stop_id].read_name;
                    }
                        
                    error = 3;
                    message = "Cannot calculate eta: ";
                    eta = track.CalcEta();

                    error = 4;
                    message = "Cannot save eta to stop history: ";
                    UpdateStopHistoryETA(track);

                    error = 5;
                    message = "Cannot save track into database: ";
                    Database.InsertTrack(track);

                    error = 0;
                    message = "success";
                }
                catch (Exception ex)
                {
                    message += ex.Message;
                }

                return serializer.Serialize(new
                {
                    error = error,
                    message = message,
                    eta = eta,
                    prevStop = prevStop,
                    prevStop_display = prevStop_display,
                    prevStop_read = prevStop_read,
                    nextStop = nextStop,
                    nextStop_display = nextStop_display,
                    nextStop_read = nextStop_read,
                    isAtStop = isAtStop,
                });
            }
            catch (Exception ex)
            {
                return "{\"error\":11, \"message\":\"exception: " + ex.Message.Replace("\"", "") + "\"}";
            }
        }

        private void UpdateStopHistoryETA(Track track)
        {
            // To save an ETA into the db, the ending track of the ETA must satisfy:
            //      it's at stop, its previous track is not at stop
            if (track.at_prev_stop == false)
                return;

            Track prevTrack = Database.GetLastTrack(track.bus_id);
            if (prevTrack == null || prevTrack.at_prev_stop == true)
                return;

            Track prevTrackAtStop = Database.GetLastTrack(track.bus_id, true);
            if (prevTrackAtStop == null || prevTrackAtStop.next_stop_id != track.prev_stop_id)
                return;

            Stop stop = DbCache.stopDict[DbCache.stopDict[track.prev_stop_id].prev_stop_id];
            stop.AddStopTime((int)(track.bus_time - prevTrackAtStop.bus_time));
            Database.UpdateStopAvgTime(stop);
        }

    }
}