using System;
using System.Collections.Generic;
using System.Text;

namespace ChatApp.DTO
{
    public class UserChatMessage
    {
        private string name;

        public string Username { get; set; }
        public string Message { get; set; }

        public UserChatMessage(string username, string message)
        {
            this.Username = username;
            this.Message = message;
        }

    }
}
