using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Configuration;

namespace BusEta
{
    public static class Config
    {
        public static string connectionString;
        public static string init_db_password;
        public static double approach_meters;
        public static double eta_formula_a;
        public static int max_stop_time_history;
        public static int max_disconnect_seconds;   // track will not be considered as continuous to last track when time difference is greater than this value

        static Config()
        {
            connectionString = WebConfigurationManager.ConnectionStrings["default_db"].ConnectionString;
            init_db_password = WebConfigurationManager.AppSettings["init_db_password"];
            approach_meters = double.Parse(WebConfigurationManager.AppSettings["approach_meters"]);
            eta_formula_a = double.Parse(WebConfigurationManager.AppSettings["eta_formula_a"]);
            max_stop_time_history = int.Parse(WebConfigurationManager.AppSettings["max_stop_time_history"]);
            max_disconnect_seconds = int.Parse(WebConfigurationManager.AppSettings["max_disconnect_seconds"]);
        }
    }
}