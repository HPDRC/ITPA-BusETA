using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Device.Location;

namespace BusEta
{
    public class Stop
    {
        public int id;
        public int route_id;
        public string name;
        public string display_name;
        public string read_name;
        public GeoCoordinate coordinate;
        public int next_stop_id;
        public double next_stop_distance;
        public int next_stop_time_avg;
        public List<int> next_stop_time_history;
        public int prev_stop_id = 0;

        public Stop(SqlDataReader reader)
        {
            id = (int)reader["id"];
            route_id = (int)reader["route_id"];
            name = (string)reader["name"];
            display_name = (string)reader["display_name"];
            read_name = (string)reader["read_name"];
            coordinate = new GeoCoordinate();
            coordinate.Latitude = (double)reader["lat"];
            coordinate.Longitude = (double)reader["lon"];
            next_stop_id = (int)reader["next_stop_id"];
            next_stop_distance = (double)reader["next_stop_distance"];
            next_stop_time_avg = (int)reader["next_stop_time_avg"];
            next_stop_time_history = Util.BytesToShortArray((byte[])reader["next_stop_time_history"]);
        }

        public void AddStopTime(int toNextStopTime)
        {
            next_stop_time_history.Add(toNextStopTime);
            if (next_stop_time_history.Count > Config.max_stop_time_history)
                next_stop_time_history.RemoveAt(0);

            List<int> timeList = new List<int>(next_stop_time_history);
            timeList.Sort();
            int start = 0, end = timeList.Count;
            if (timeList.Count >= 4)
            {
                start = end / 4;
                end *= 3 / 4;
            }
            int totalTime = 0;
            for (int i=start; i < end; i++)
                totalTime += timeList[i];
            totalTime /= end - start;
            next_stop_time_avg = totalTime;
        }
    }
}