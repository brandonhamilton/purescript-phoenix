/* global exports */
exports.newSocketImpl = function(endpoint) {
  return function(options) {
    return function() {
      return new window.Phoenix.Socket(endpoint, options);
    }
  }
}

exports.connect = function(socket) {
  return function() {
    socket.connect();
  }
}

exports.disconnect = function(socket) {
  return function(callback) {
    return function(code) {
      return function(reason) {
        return function() {
          socket.disconnect(callback(socket), code, reason);
        }
      }
    }
  }
}

exports.sendHeartbeat = function(socket) {
  return function() {
    socket.sendHeartbeat();
  }
}

exports.flushSendBuffer = function(socket) {
  return function() {
    socket.flushSendBuffer();
  }
}

exports.isConnected = function(socket) {
  return function() {
    return socket.isConnected();
  }
}

exports.connectionStateImpl = function(socket) {
  return function() {
    return socket.connectionState();
  }
}

exports.protocol = function(socket) {
  return function() {
    return socket.protocol();
  }
}

exports.endPointURL = function(socket) {
  return function() {
    return socket.endPointURL();
  }
}

function registerCallback0(_this, func) {
  return function(callback) {
    return function() {
      return _this[func](callback(_this));
    }
  }
}

function registerCallback1(_this, func) {
  return function(callback) {
    return function() {
      return _this[func](function(arg) {
        return callback(_this)(arg)();
      });
    }
  }
}

exports.onOpen         = function(socket)  { return registerCallback0(socket,  'onOpen') };
exports.onMessage      = function(socket)  { return registerCallback1(socket,  'onMessage') };

exports.onSocketClose  = function(socket)  { return registerCallback1(socket,  'onClose') };
exports.onSocketError  = function(socket)  { return registerCallback1(socket,  'onError') };
exports.onChannelClose = function(channel) { return registerCallback1(channel, 'onClose') };
exports.onChannelError = function(channel) { return registerCallback1(channel, 'onError') };

exports.channel = function(socket) {
  return function(topic) {
    return function(params) {
      return function() {
          return socket.channel(topic, params);
      }
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

exports.makeRef = function(socket) {
  return function() {
    return socket.makeRef();
  }
}

exports.join = function(channel) {
  return function() {
    return channel.join();
  }
}

exports.rejoinUntilConnected = function(channel) {
  return function() {
    return channel.rejoinUntilConnected();
  }
}

exports.leave = function(channel) {
  return function() {
    return channel.leave();
  }
}

exports.canPush = function(channel) {
  return function() {
    return channel.canPush();
  }
}

exports.push = function(channel) {
  return function(event) {
    return function(payload) {
      return function() {
        return channel.push(event, payload);
      }
    }
  }
}

exports.on = function(channel) {
  return function(event) {
    return function(callback) {
      return function() {
        return channel.on(event, function(arg) {
          callback(channel)(event)(arg)();
        });
      }
    }
  }
}

exports.off = function(channel) {
  return function(event) {
    return function() {
      return channel.off(event);
    }
  }
}

exports.send = function(push) {
  return function() {
    return push.send();
  }
}

exports.receive = function(push) {
  return function(status) {
    return function(callback) {
      return function() {
        return push.receive(status, function() {
          var cb = callback(push);
          [].slice.call(arguments).forEach(function (arg) { cb = cb(arg); });
          return cb();
        });
      }
    }
  }
}
