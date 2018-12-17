using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

namespace BusEta
{
    public static class Database
    {
        public static List<Stop> GetAllStops()
        {
            List<Stop> result = new List<Stop>();
            using (SqlConnection connection = new SqlConnection(Config.connectionString))
            {
                SqlCommand cmd = new SqlCommand("select * from stops", connection);
                connection.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                try
                {
                    while (reader.Read())
                        result.Add(new Stop(reader));
                }
                finally
                {
                    reader.Close();
                }
            }
            return result;
        }

        public static List<Bus> GetAllBuses()
        {
            List<Bus> result = new List<Bus>();
            using (SqlConnection connection = new SqlConnection(Config.connectionString))
            {
                SqlCommand cmd = new SqlCommand("select * from buses", connection);
                connection.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                try
                {
                    while (reader.Read())
                        result.Add(new Bus(reader));
                }
                finally
                {
                    reader.Close();
                }
            }
            return result;
        }

        public static List<Log> GetAllLogs(int offset, int logCount, int bus_id)
        {
            if (offset <= 0)
                offset = 0;
            if (logCount <= 0)
                logCount = 100;
            List<Log> result = new List<Log>();
            using (SqlConnection connection = new SqlConnection(Config.connectionString))
            {
                string cmdString = string.Format("select * from logs {0} order by id desc offset {1} rows fetch next {2} rows only", bus_id <= 0 ? "" : "where bus_id=" + bus_id, offset, logCount);
                SqlCommand cmd = new SqlCommand(cmdString, connection);
                connection.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                try
                {
                    while (reader.Read())
                        result.Add(new Log(reader));
                }
                finally
                {
                    reader.Close();
                }
            }
            return result;
        }

        public static List<Track> GetAllTracks(int offset, int logCount, int bus_id)
        {
            if (offset <= 0)
                offset = 0;
            if (logCount <= 0)
                logCount = 100;
            List<Track> result = new List<Track>();
            using (SqlConnection connection = new SqlConnection(Config.connectionString))
            {
                string cmdString = string.Format("select * from tracks {0} order by id desc offset {1} rows fetch next {2} rows only", bus_id <= 0 ? "" : "where bus_id=" + bus_id, offset, logCount);
                SqlCommand cmd = new SqlCommand(cmdString, connection);
                connection.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                try
                {
                    while (reader.Read())
                        result.Add(new Track(reader));
                }
                finally
                {
                    reader.Close();
                }
            }
            return result;
        }

        public static bool UpdateStopInit(Stop stop)
        {
            return ExecNonQuery(string.Format("update stops set next_stop_distance = {0}, next_stop_time_avg = {1}, last_update = {2} where id = {3}",
                    stop.next_stop_distance, stop.next_stop_time_avg, Util.UtcTimestamp(), stop.id)) == 1 ? true : false;
        }

        public static void UpdateStopAvgTime(Stop stop)
        {
            using (SqlConnection connection = new SqlConnection(Config.connectionString))
            {
                SqlCommand command = new SqlCommand("update stops set next_stop_time_avg = @avg, next_stop_time_history = @history, last_update = @timenow where id = @id", connection);
                command.Parameters.AddWithValue("@avg", stop.next_stop_time_avg);
                command.Parameters.AddWithValue("@history", Util.ShortArrayToBytes(stop.next_stop_time_history));
                command.Parameters.AddWithValue("@timenow", Util.UtcTimestamp());
                command.Parameters.AddWithValue("@id", stop.id);
                connection.Open();
                command.ExecuteNonQuery();
                connection.Close();
            }
        }

        public static Track GetLastTrack(int busId, bool onlyAtStop = false)
        {
            Track result = null;
            using (SqlConnection connection = new SqlConnection(Config.connectionString))
            {
                SqlCommand cmd = new SqlCommand("select top 1 * from tracks where bus_id = " + busId + (onlyAtStop ? " and at_prev_stop != 0" : "") + " order by id desc", connection);
                connection.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                try
                {
                    while (reader.Read())
                    {
                        result = new Track(reader);
                        break;
                    }
                }
                finally
                {
                    reader.Close();
                }
            }
            return result;
        }

        public static void InsertTrack(Track track)
        {
            ExecNonQuery(string.Format("insert into tracks values ({0}, {1}, {2}, {3}, {4}, {5}, {6}, {7}, {8}, {9}, {10})", 
                track.bus_id, track.coordinate.Latitude, track.coordinate.Longitude,
                track.speed, track.bearing, track.accuracy, track.bus_time, track.server_time, 
                track.prev_stop_id, track.next_stop_id, (track.at_prev_stop ? 1 : 0)));
        }

        public static void AddLog(int bus_id, string message, Int64 bus_time)
        {
            using (SqlConnection connection = new SqlConnection(Config.connectionString))
            {
                SqlCommand command = new SqlCommand("insert into logs values (@bus_id, @message, @bus_time, @server_time)", connection);
                command.Parameters.AddWithValue("@bus_id", bus_id);
                command.Parameters.AddWithValue("@message", message);
                command.Parameters.AddWithValue("@bus_time", bus_time);
                command.Parameters.AddWithValue("@server_time", Util.UtcTimestamp());
                connection.Open();
                command.ExecuteNonQuery();
                connection.Close();
            }
        }

        private static int ExecNonQuery(string cmd)
        {
            int rowsAffected = 0;
            using (SqlConnection connection = new SqlConnection(Config.connectionString))
            {
                SqlCommand command = new SqlCommand(cmd, connection);
                connection.Open();
                rowsAffected = command.ExecuteNonQuery();
                connection.Close();
            }
            return rowsAffected;
        }
    }
}