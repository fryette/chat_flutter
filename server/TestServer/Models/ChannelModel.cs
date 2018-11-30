// Developed for LilBytes by Softeq Development Corporation
//
using System;
using System.Collections.Generic;

namespace TestServer.Models
{
    public class ChannelModel
    {
        public string Id { get; set; }
        public DateTimeOffset CreatedDate { get; set; }
        public DateTimeOffset? UpdatedDate { get; set; }
        public string Name { get; set; }
        public int UnreadMessagesCount { get; set; }
        public bool IsMuted { get; set; }
        public string CreatorId { get; set; }
        public bool IsCreatedByMe { get; set; }
        public string AvatarUrl { get; set; }
        public Message LastMessage { get; set; }
        public IList<string> TypingUsersNames { get; set; }
        public bool AreMoreThanThreeUsersTyping { get; set; }
    }
}
