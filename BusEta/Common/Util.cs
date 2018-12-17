using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BusEta
{
    public static class Util
    {
        public static List<int> BytesToShortArray(byte[] bArray)
        {
            List<int> result = new List<int>();
            for (int i=0; i<bArray.Length; i+=2)
            {
                if (i+1 < bArray.Length)
                {
                    result.Add((((int)bArray[i]) << 8) + bArray[i+1]);
                }
            }
            return result;
        }

        public static byte[] ShortArrayToBytes(List<int> sArray)
        {
            byte[] result = new byte[sArray.Count * 2];
            for (int i=0; i<sArray.Count; i++)
            {
                result[i * 2] = (byte)(sArray[i] >> 8);
                result[i * 2 + 1] = (byte)(sArray[i] & 0xFF);
            }
            return result;
        }

        public static long UtcTimestamp()
        {
            return (long)(DateTime.UtcNow - new DateTime(1970, 1, 1)).TotalSeconds;
        }

        public static DateTime UnixTimeStampToDateTime(long unixTimeStamp)
        {
            // Unix timestamp is seconds past epoch
            System.DateTime dtDateTime = new DateTime(1970, 1, 1, 0, 0, 0, 0, System.DateTimeKind.Utc);
            dtDateTime = dtDateTime.AddSeconds(unixTimeStamp).ToLocalTime();
            return dtDateTime;
        }
    }
}