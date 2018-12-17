using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Device.Location;
using System.Data.SqlClient;

namespace BusEta
{
    public class Track
    {
        public int id;
        public int bus_id;
        public GeoCoordinate coordinate;
        public double speed;
        public double bearing;
        public double accuracy;
        public long bus_time;
        public long server_time;

        public int prev_stop_id;
        public int next_stop_id;
        public bool at_prev_stop;

        public DateTime busDateTime
        {
            get { return Util.UnixTimeStampToDateTime(bus_time); }
        }

        public DateTime serverDateTime
        {
            get { return Util.UnixTimeStampToDateTime(server_time); }
        }

        public Track(HttpRequest request)
        {
            bus_id = int.Parse(request["bus_id"]);
            coordinate = new GeoCoordinate();
            coordinate.Latitude = double.Parse(request["lat"]);
            coordinate.Longitude = double.Parse(request["lon"]);
            speed = double.Parse(request["speed"]);
            bearing = double.Parse(request["bearing"]);
            accuracy = double.Parse(request["accuracy"]);
            bus_time = long.Parse(request["bus_time"]);
            server_time = Util.UtcTimestamp();
        }

        public Track(SqlDataReader reader)
        {
            id = (int)reader["id"];
            bus_id = (int)reader["bus_id"];
            coordinate = new GeoCoordinate();
            coordinate.Latitude = (double)reader["lat"];
            coordinate.Longitude = (double)reader["lon"];
            speed = (double)reader["speed"];
            bearing = (double)reader["bearing"];
            accuracy = (double)reader["accuracy"];
            bus_time = (long)reader["bus_time"];
            server_time = (long)reader["server_time"];
            prev_stop_id = (int)reader["prev_stop_id"];
            next_stop_id = (int)reader["next_stop_id"];
            at_prev_stop = (byte)reader["at_prev_stop"] != 0 ? true : false;
        }

        public void CalcFields()
        {
            // calc route_id
            int routeId = 0;
            List<Bus> buses = DbCache.busList;
            foreach (Bus bus in buses)
            {
                if (bus.id == bus_id)
                {
                    routeId = bus.route_id;
                    break;
                }
            }
            if (routeId == 0)
                throw new Exception("bus id " + bus_id + " is not found in the database");

            // calc the nearest approaching stop, if any
            Stop nearestStop = GetNearestStop(routeId);
            if (nearestStop.coordinate.GetDistanceTo(coordinate) < Config.approach_meters)  // the bus is approaching a stop
            {
                prev_stop_id = nearestStop.id;
                next_stop_id = nearestStop.next_stop_id;
                at_prev_stop = true;
            }
            else
            {
                Track prevTrack = Database.GetLastTrack(bus_id);
                Stop prevStop = (prevTrack == null || prevTrack.prev_stop_id == 0 || prevTrack.next_stop_id == 0) ? null : DbCache.stopDict[prevTrack.prev_stop_id];
                if (prevStop == null || bus_time - prevTrack.bus_time > Config.max_disconnect_seconds)
                {
                    prev_stop_id = 0;
                    next_stop_id = 0;
                    at_prev_stop = false;
                }
                else
                {
                    prev_stop_id = prevTrack.prev_stop_id;
                    next_stop_id = prevTrack.next_stop_id;
                    at_prev_stop = false;
                }
            }
        }

        public int CalcEta()
        {
            if (prev_stop_id == 0)
                return -1;
            if (at_prev_stop)
                return DbCache.stopDict[prev_stop_id].next_stop_time_avg;

            Track prevTrackAtStop = Database.GetLastTrack(bus_id, true);
            if (prevTrackAtStop == null || prevTrackAtStop.at_prev_stop != true || prevTrackAtStop.prev_stop_id != prev_stop_id)
                return -1;
            int timeElapsed = (int)(bus_time - prevTrackAtStop.bus_time);
            int timeTotal = DbCache.stopDict[prev_stop_id].next_stop_time_avg;
            double distTotal = DbCache.stopDict[prev_stop_id].next_stop_distance;
            double distLeft = coordinate.GetDistanceTo(DbCache.stopDict[next_stop_id].coordinate);
            return (int)(Math.Max(timeTotal - timeElapsed, 0) * Config.eta_formula_a + distLeft * timeTotal / distTotal * (1 - Config.eta_formula_a));
        }

        private Stop GetNearestStop(int routeId)
        {
            Dictionary<int, Stop> stops = DbCache.stopDict;
            Stop nearestStop = null;
            double nearestDist = 0;
            foreach (KeyValuePair<int, Stop> pair in stops)
            {
                Stop current = pair.Value;
                if (current.route_id != routeId)
                    continue;
                if (nearestStop == null)
                {
                    nearestStop = current;
                    nearestDist = current.coordinate.GetDistanceTo(coordinate);
                }
                else
                {
                    double dist = current.coordinate.GetDistanceTo(coordinate);
                    if (dist < nearestDist)
                    {
                        nearestDist = dist;
                        nearestStop = current;
                    }
                }
            }
            return nearestStop;
        }

    }
}