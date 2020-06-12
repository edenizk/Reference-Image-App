using Microsoft.AspNetCore.SignalR;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using ChatApp.DTO;

namespace ChatApp.Web.Hubs
{
    public class ChatHub : Hub
    {
        public async Task SendMessage(object name, object message)
        {

            UserChatMessage userChatMessage = new UserChatMessage(name.ToString(), message.ToString());
            await Clients.All.SendAsync(Consts.RECIEVE_MESSAGE, new object[] { name, message });
        }
    }
}
