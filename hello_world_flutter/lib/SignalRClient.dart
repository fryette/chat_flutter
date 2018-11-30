import 'package:signalr_client/signalr_client.dart';

enum ClientEvents {
  MessageDeleted,
  MessageAdded,
  MessageUpdated,
  TypingStarted,
  TypingEnded,
  AttachmentAdded,
  AttachmentDeleted,
  MemberLeft,
  MemberJoined,
  ChannelAdded,
  ChannelClosed,
  ChannelUpdated,
  AccessTokenExpired,
  ExceptionOccurred,
  RequestSuccess,
}

class SignalRClient {
  HubConnection _hubConnection;

  bool connectionIsOpen;

  Future connect(String serverUrl, String token) async {
    if (_hubConnection == null) {
      _hubConnection = HubConnectionBuilder().withUrl(serverUrl).build();
      _hubConnection.onclose((error) => connectionIsOpen = false);
      _hubConnection.on("OnMessage", _handleIncommingChatMessage);
    }

    if (_hubConnection.state != HubConnectionState.Connected) {
      await _hubConnection.start();
      connectionIsOpen = true;
    }
  }

  void _subscribeOnEvents() {
    _hubConnection.on(ClientEvents.MessageDeleted.toString(), _handleEvent);
    _hubConnection.on(ClientEvents.MessageAdded.toString(), _handleEvent);
    _hubConnection.on(ClientEvents.MessageUpdated.toString(), _handleEvent);
    _hubConnection.on(ClientEvents.TypingStarted.toString(), _handleEvent);
    _hubConnection.on(ClientEvents.TypingEnded.toString(), _handleEvent);
    _hubConnection.on(ClientEvents.AttachmentAdded.toString(), _handleEvent);
    _hubConnection.on(ClientEvents.AttachmentDeleted.toString(), _handleEvent);
    _hubConnection.on(ClientEvents.MemberJoined.toString(), _handleEvent);
    _hubConnection.on(ClientEvents.MemberLeft.toString(), _handleEvent);
    _hubConnection.on(ClientEvents.ChannelAdded.toString(), _handleEvent);
    _hubConnection.on(ClientEvents.ChannelUpdated.toString(), _handleEvent);
    _hubConnection.on(ClientEvents.ChannelClosed.toString(), _handleEvent);
    _hubConnection.on(ClientEvents.AccessTokenExpired.toString(), _handleEvent);
    _hubConnection.on(ClientEvents.ExceptionOccurred.toString(), _handleEvent);
    _hubConnection.on(ClientEvents.RequestSuccess.toString(), _handleEvent);
  }

  void _handleEvent(List<Object> data) {
    print("recieved");
  }

  Future disconnect() async {
    _hubConnection.stop();
  }

  void _handleIncommingChatMessage(List<Object> arguments) {}
}
