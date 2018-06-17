module Phoenix
  ( Socket()
  , Channel()
  , Push()
  , ConnectionState(SocketConnecting,SocketOpen,SocketClosing,SocketClosed)
  , Endpoint()
  , Topic()
  , Event()
  , Status()
  , Message()
  
  , defaultSocketOptions
  , timeout
  , heartbeatIntervalMs
  , reconnectAfterMs
  , params

  , newSocket
  , connect
  , disconnect
  , channel
  , remove
  , sendHeartbeat
  , flushSendBuffer
  , makeRef

  , protocol
  , endPointURL
  , isConnected
  , connectionState

  , onOpen
  , onMessage
  , onSocketError
  , onSocketClose

  , join
  , push
  , leave

  , rejoinUntilConnected
  , canPush

  , onChannelError
  , onChannelClose
  , on
  , off

  , send
  , receive

  ) where

import Prelude (Unit, (<$>))
import Effect (Effect())
import Data.Monoid (mempty)
import Foreign (Foreign())
import Data.Options (Options, Option, opt, options)

-- | A Phoenix Socket
foreign import data Socket :: Type

-- | A Phoenix Channel
foreign import data Channel :: Type

-- | A Phoenix Push object
foreign import data Push :: Type

data ConnectionState = SocketConnecting | SocketOpen | SocketClosing | SocketClosed

-- | An Endpoint URL is just a string
type Endpoint = String

type Topic = String

type Event = String

type Status = String

type Message = {
  topic   :: Topic,
  event   :: Event,
  payload :: Foreign,
  ref     :: String
}

-- | Socket options
defaultSocketOptions :: Options Socket
defaultSocketOptions = mempty

timeout :: Option Socket Int
timeout = opt "timeout"

heartbeatIntervalMs :: Option Socket Int
heartbeatIntervalMs = opt "heartbeatIntervalMs"

reconnectAfterMs :: Option Socket (Int -> Int)
reconnectAfterMs = opt "reconnectAfterMs"

params :: Option Socket Foreign
params = opt "params"

-- | Create a new Phoenix Socket
newSocket :: Endpoint -> Options Socket -> Effect Socket
newSocket e o = newSocketImpl e (options o)

foreign import newSocketImpl :: Endpoint -> Foreign -> Effect Socket

-- | Socket operations
foreign import connect :: Socket -> Effect Unit
foreign import disconnect :: forall a. Socket -> (Socket -> Effect a) -> Int -> String -> Effect Unit

foreign import channel :: Socket -> Topic -> Foreign -> Effect Channel
foreign import remove :: Socket -> Channel -> Effect Unit

foreign import sendHeartbeat :: Socket -> Effect Unit
foreign import flushSendBuffer :: Socket -> Effect Unit
foreign import makeRef :: Socket -> Effect String

foreign import protocol :: Socket -> Effect String
foreign import endPointURL :: Socket -> Effect String
foreign import isConnected :: Socket -> Effect Boolean

connectionState :: Socket -> Effect ConnectionState
connectionState s = cs <$> connectionStateImpl s
  where
    cs :: String -> ConnectionState
    cs "connecting" = SocketConnecting
    cs "open"       = SocketOpen
    cs "closing"    = SocketClosing
    cs _            = SocketClosed

foreign import connectionStateImpl :: Socket -> Effect String

-- | Register callbacks
foreign import onOpen        :: forall a. Socket -> (Socket -> Effect a) -> Effect Unit
foreign import onMessage     :: forall a. Socket -> (Socket -> Message -> Effect a) -> Effect Unit
foreign import onSocketClose :: forall a. Socket -> (Socket -> String -> Effect a) -> Effect Unit
foreign import onSocketError :: forall a. Socket -> (Socket -> String -> Effect a) -> Effect Unit

-- | Channel operations
foreign import join :: Channel -> Effect Push
foreign import push :: Channel -> Event -> Foreign -> Effect Push
foreign import leave :: Channel -> Effect Push

foreign import rejoinUntilConnected  :: Channel -> Effect Unit
foreign import canPush :: Channel -> Effect Boolean

-- | Register callbacks
foreign import onChannelClose :: forall a. Channel -> (Channel -> Event -> Effect a) -> Effect Unit
foreign import onChannelError :: forall a. Channel -> (Channel -> String -> Effect a) -> Effect Unit

-- | Listen for messages on a channel
foreign import on  :: forall a. Channel -> Event -> (Channel -> Event -> Foreign -> Effect a) -> Effect Unit
foreign import off :: Channel -> Event -> Effect Unit

-- | Push operations
foreign import send    :: Push -> Effect Unit
foreign import receive :: forall a. Push -> Status -> (Push -> Foreign -> Effect a) -> Effect Push
