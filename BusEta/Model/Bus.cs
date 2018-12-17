using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;

namespace BusEta
{
    public class Bus
    {
        public int id;
        public int route_id;
        public string name;

        public Bus(SqlDataReader reader)
        {
            id = (int)reader["id"];
            route_id = (int)reader["route_id"];
            name = (string)reader["name"];
        }
    }
}