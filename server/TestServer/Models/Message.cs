// Developed for LilBytes by Softeq Development Corporation
//
using System;
namespace TestServer.Models
{
    public class Message : IEquatable<Message>
    {
        public string Id { get; set; }
        public string ChannelId { get; set; }
        public string SenderId { get; set; }
        public string SenderName { get; set; }
        public string SenderPhotoUrl { get; set; }
        public bool IsMine { get; set; }
        public bool IsDelivered { get; set; }
        public bool IsRead { get; set; }
        public MessageType MessageType { get; set; }
        public string Body { get; set; }
        public DateTimeOffset DateTime { get; set; }
        public string ImageUrl { get; set; }

        public ChatMessageStatus Status
        {
            get
            {
                if (!IsMine)
                {
                    return ChatMessageStatus.Other;
                }
                if (!IsDelivered)
                {
                    return ChatMessageStatus.Sending;
                }
                return IsRead ? ChatMessageStatus.Read : ChatMessageStatus.Delivered;
            }
        }

        public void UpdateIsMineStatus(string currentUserId)
        {
            IsMine = SenderId == currentUserId;
        }

        public bool Equals(Message other)
        {
            if (other is null)
            {
                return false;
            }
            if (ReferenceEquals(this, other))
            {
                return true;
            }
            if (Id != null)
            {
                return Id == other.Id;
            }
            return Body == other.Body && DateTime == other.DateTime;
        }

        public override bool Equals(object obj) => Equals(obj as Message);

        public override int GetHashCode()
        {
            return Id == null ? 0 : Id.GetHashCode();
        }
    }

    public enum MessageType
    {
        Default = 0,
        Info = 1
    }

    public enum ChatMessageStatus
    {
        Other = 0,
        Sending = 1,
        Delivered = 2,
        Read = 3
    }
}
