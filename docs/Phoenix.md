## Module Phoenix

#### `PHOENIX`

``` purescript
data PHOENIX :: !
```

The `Phoenix` effect denotes computations which read/write from/to the Phoenix Channels.

#### `Socket`

``` purescript
data Socket :: *
```

A Phoenix Socket

#### `Channel`

``` purescript
data Channel :: *
```

A Phoenix Channel

#### `Push`

``` purescript
data Push :: *
```

A Phoenix Push object

#### `ConnectionState`

``` purescript
data ConnectionState
  = SocketConnecting
  | SocketOpen
  | SocketClosing
  | SocketClosed
```

#### `Endpoint`

``` purescript
type Endpoint = String
```

An Endpoint URL is just a string

#### `Topic`

``` purescript
type Topic = String
```

#### `Event`

``` purescript
type Event = String
```

#### `Status`

``` purescript
type Status = String
```

#### `Message`

``` purescript
type Message = { topic :: Topic, event :: Event, payload :: Foreign, ref :: String }
```

#### `defaultSocketOptions`

``` purescript
defaultSocketOptions :: Options Socket
```

Socket options

#### `timeout`

``` purescript
timeout :: Option Socket Int
```

#### `heartbeatIntervalMs`

``` purescript
heartbeatIntervalMs :: Option Socket Int
```

#### `reconnectAfterMs`

``` purescript
reconnectAfterMs :: Option Socket (Int -> Int)
```

#### `params`

``` purescript
params :: Option Socket Foreign
```

#### `newSocket`

``` purescript
newSocket :: forall eff. Endpoint -> Options Socket -> Eff (phoenix :: PHOENIX | eff) Socket
```

Create a new Phoenix Socket

#### `connect`

``` purescript
connect :: forall eff. Socket -> Eff (phoenix :: PHOENIX | eff) Unit
```

Socket operations

#### `disconnect`

``` purescript
disconnect :: forall eff a. Socket -> (Socket -> Eff (phoenix :: PHOENIX | eff) a) -> Int -> String -> Eff (phoenix :: PHOENIX | eff) Unit
```

#### `channel`

``` purescript
channel :: forall eff. Socket -> Topic -> Foreign -> Eff (phoenix :: PHOENIX | eff) Channel
```

#### `remove`

``` purescript
remove :: forall eff. Socket -> Channel -> Eff (phoenix :: PHOENIX | eff) Unit
```

#### `sendHeartbeat`

``` purescript
sendHeartbeat :: forall eff. Socket -> Eff (phoenix :: PHOENIX | eff) Unit
```

#### `flushSendBuffer`

``` purescript
flushSendBuffer :: forall eff. Socket -> Eff (phoenix :: PHOENIX | eff) Unit
```

#### `makeRef`

``` purescript
makeRef :: forall eff. Socket -> Eff (phoenix :: PHOENIX | eff) String
```

#### `protocol`

``` purescript
protocol :: forall eff. Socket -> Eff (phoenix :: PHOENIX | eff) String
```

#### `endPointURL`

``` purescript
endPointURL :: forall eff. Socket -> Eff (phoenix :: PHOENIX | eff) String
```

#### `isConnected`

``` purescript
isConnected :: forall eff. Socket -> Eff (phoenix :: PHOENIX | eff) Boolean
```

#### `connectionState`

``` purescript
connectionState :: forall eff. Socket -> Eff (phoenix :: PHOENIX | eff) ConnectionState
```

#### `onOpen`

``` purescript
onOpen :: forall eff a. Socket -> (Socket -> Eff (phoenix :: PHOENIX | eff) a) -> Eff (phoenix :: PHOENIX | eff) Unit
```

Register callbacks

#### `onMessage`

``` purescript
onMessage :: forall eff a. Socket -> (Socket -> Message -> Eff (phoenix :: PHOENIX | eff) a) -> Eff (phoenix :: PHOENIX | eff) Unit
```

#### `onSocketClose`

``` purescript
onSocketClose :: forall eff a. Socket -> (Socket -> String -> Eff (phoenix :: PHOENIX | eff) a) -> Eff (phoenix :: PHOENIX | eff) Unit
```

#### `onSocketError`

``` purescript
onSocketError :: forall eff a. Socket -> (Socket -> String -> Eff (phoenix :: PHOENIX | eff) a) -> Eff (phoenix :: PHOENIX | eff) Unit
```

#### `join`

``` purescript
join :: forall eff. Channel -> Eff (phoenix :: PHOENIX | eff) Push
```

Channel operations

#### `push`

``` purescript
push :: forall eff. Channel -> Event -> Foreign -> Eff (phoenix :: PHOENIX | eff) Push
```

#### `leave`

``` purescript
leave :: forall eff. Channel -> Eff (phoenix :: PHOENIX | eff) Push
```

#### `rejoinUntilConnected`

``` purescript
rejoinUntilConnected :: forall eff. Channel -> Eff (phoenix :: PHOENIX | eff) Unit
```

#### `canPush`

``` purescript
canPush :: forall eff. Channel -> Eff (phoenix :: PHOENIX | eff) Boolean
```

#### `onChannelClose`

``` purescript
onChannelClose :: forall eff a. Channel -> (Channel -> Event -> Eff (phoenix :: PHOENIX | eff) a) -> Eff (phoenix :: PHOENIX | eff) Unit
```

Register callbacks

#### `onChannelError`

``` purescript
onChannelError :: forall eff a. Channel -> (Channel -> String -> Eff (phoenix :: PHOENIX | eff) a) -> Eff (phoenix :: PHOENIX | eff) Unit
```

#### `on`

``` purescript
on :: forall eff a. Channel -> Event -> (Channel -> Event -> Foreign -> Eff (phoenix :: PHOENIX | eff) a) -> Eff (phoenix :: PHOENIX | eff) Unit
```

Listen for messages on a channel

#### `off`

``` purescript
off :: forall eff. Channel -> Event -> Eff (phoenix :: PHOENIX | eff) Unit
```

#### `send`

``` purescript
send :: forall eff. Push -> Eff (phoenix :: PHOENIX | eff) Unit
```

Push operations

#### `receive`

``` purescript
receive :: forall eff a. Push -> Status -> (Push -> Foreign -> Eff (phoenix :: PHOENIX | eff) a) -> Eff (phoenix :: PHOENIX | eff) Push
```


