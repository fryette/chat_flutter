using System.Collections.Generic;
using TestServer.Models;

namespace TestServer
{
    public static class God
    {
        public static Dictionary<string, List<ChannelModel>> Channels;

        static God()
        {
            Channels = new Dictionary<string, List<ChannelModel>>();
        }

        public static void CreateChannel(string userId, ChannelModel channel)
        {
            if (Channels.ContainsKey(userId))
            {
                Channels[userId].Add(channel);
            }
        }
    }
}