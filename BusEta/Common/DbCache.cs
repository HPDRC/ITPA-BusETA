using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BusEta
{
    public static class DbCache
    {
        public static Dictionary<int, Stop> stopDict;
        public static List<Bus> busList;

        static DbCache()
        {
            Update();
        }

        private static void Update()
        {
            List<Stop> stopList = Database.GetAllStops();
            Dictionary<int, Stop> stopDictLocal = new Dictionary<int, Stop>();
            foreach (Stop stop in stopList)
                stopDictLocal.Add(stop.id, stop);
            foreach (Stop stop in stopList)
                stopDictLocal[stop.next_stop_id].prev_stop_id = stop.id;
            stopDict = stopDictLocal;
            busList = Database.GetAllBuses();
        }
    }
}