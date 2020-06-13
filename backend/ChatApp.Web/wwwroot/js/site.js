var connection = new signalR.HubConnectionBuilder().withUrl("chatHub").build();

//Disable send button until connection is established
document.getElementById("sendButton").disabled = true;

connection.on("ReceiveMessage", function (message) {
    console.log(message);
    let userName = document.getElementById("userInput").value;
    let content = document.createElement('div');;
    content.className = "mt-3";
    if (message[1].startsWith("image::")) {
        let img = document.createElement('img');
        img.style.maxWidth = 200 + 'px';
        img.classList.add("img-thumbnail");
        content.append(img);
        img.setAttribute('src', message[1].substring(7));
        if (userName != message[0]) {
            setTimeout(
                function () {
                    img.setAttribute('src', message[1].substring(7));
                }, 5000);
        }
        
    } else {
        content.className = ("d-flex flex-column mb-4")
        let user = document.createElement('small');
        user.className = ('text-muted');
        user.textContent = message[0];
        let messageWrapper = document.createElement('div');
        messageWrapper.className = "d-flex msg_wrapper";
        let msg = document.createElement('span');
        msg.className = ('card p-1 mt-1');
        msg.textContent = message[1];
        messageWrapper.append(msg);
        content.append(user)
        content.append(messageWrapper);
    }
    if (userName == message[0]) {
        content.classList.add('text-right');
    }
    document.getElementById("msg_card_body").append(content);
});

connection.start().then(function () {
    document.getElementById("sendButton").disabled = false;
}).catch(function (err) {
    return console.error(err.toString());
});

document.getElementById("sendButton").addEventListener("click", function (event) {
    let userName = document.getElementById("userInput");
    let message = document.getElementById("messageInput");
    let usernameValue = userName.value == '' ? 'No Name' : userName.value;
    connection.invoke("SendMessage", usernameValue, message.value
      ).catch(function (err) {
        return console.error(err.toString());
      });
    message.value = '';
    event.preventDefault();
});