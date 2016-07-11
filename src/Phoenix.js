/* global exports */
exports.newSocket = function(endpoint) {
  return function() {
    return new window.Phoenix.Socket(endpoint);
  }
}

exports.connect = function(socket) {
  return function() {
    socket.connect();
  }
}

exports.channel = function(socket) {
  return function(topic) {
    return function() {
      return socket.channel(topic);
    }
  }
}

exports.remove = function(socket) {
  return function(channel) {
    return function() {
      socket.remove(channel);
    }
  }
}

exports.join = function(channel) {
  return function() {
    return channel.join();
  }
}

exports.leave = function(channel) {
  return function() {
    return channel.leave();
  }
}

exports.push = function(channel) {
  return function(event) {
    return function(payload) {
      return channel.push(event, payload);
    }
  }
}