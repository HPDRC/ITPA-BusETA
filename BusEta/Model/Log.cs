using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;

namespace BusEta
{
    public class Log
    {
        public int id;
        public int bus_id;
        public string message;
        public long bus_time;
        public long server_time;

        public DateTime busDateTime
        {
            get { return Util.UnixTimeStampToDateTime(bus_time); }
        }

        public DateTime serverDateTime
        {
            get { return Util.UnixTimeStampToDateTime(server_time); }
        }


        public Log(SqlDataReader reader)
        {
            id = (int)reader["id"];
            bus_id = (int)reader["bus_id"];
            message = (string)reader["message"];
            bus_time = (long)reader["bus_time"];
            server_time = (long)reader["server_time"];
        }
    }
}