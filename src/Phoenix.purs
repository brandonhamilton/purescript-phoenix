module Phoenix
  (
    PHOENIX()
  , Socket()
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
import Control.Monad.Eff (Eff, kind Effect)
import Data.Monoid (mempty)
import Data.Foreign (Foreign())
import Data.Options (Options, Option, opt, options)

-- | The `Phoenix` effect denotes computations which read/write from/to the Phoenix Channels.
foreign import data PHOENIX :: Effect

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
newSocket :: forall eff. Endpoint -> Options Socket -> Eff (phoenix :: PHOENIX | eff) Socket
newSocket e o = newSocketImpl e (options o)

foreign import newSocketImpl :: forall eff. Endpoint -> Foreign -> Eff (phoenix :: PHOENIX | eff) Socket

-- | Socket operations
foreign import connect :: forall eff. Socket -> Eff (phoenix :: PHOENIX | eff) Unit
foreign import disconnect :: forall eff a. Socket -> (Socket -> Eff (phoenix :: PHOENIX | eff) a) -> Int -> String -> Eff (phoenix :: PHOENIX | eff) Unit

foreign import channel :: forall eff. Socket -> Topic -> Foreign -> Eff (phoenix :: PHOENIX | eff) Channel
foreign import remove :: forall eff. Socket -> Channel -> Eff (phoenix :: PHOENIX | eff) Unit

foreign import sendHeartbeat :: forall eff. Socket -> Eff (phoenix :: PHOENIX | eff) Unit
foreign import flushSendBuffer :: forall eff. Socket -> Eff (phoenix :: PHOENIX | eff) Unit
foreign import makeRef :: forall eff. Socket -> Eff (phoenix :: PHOENIX | eff) String

foreign import protocol :: forall eff. Socket -> Eff (phoenix :: PHOENIX | eff) String
foreign import endPointURL :: forall eff. Socket -> Eff (phoenix :: PHOENIX | eff) String
foreign import isConnected :: forall eff. Socket -> Eff (phoenix :: PHOENIX | eff) Boolean

connectionState :: forall eff. Socket -> Eff (phoenix :: PHOENIX | eff) ConnectionState
connectionState s = cs <$> connectionStateImpl s
  where
    cs :: String -> ConnectionState
    cs "connecting" = SocketConnecting
    cs "open"       = SocketOpen
    cs "closing"    = SocketClosing
    cs _            = SocketClosed

foreign import connectionStateImpl :: forall eff. Socket -> Eff (phoenix :: PHOENIX | eff) String

-- | Register callbacks
foreign import onOpen        :: forall eff a. Socket -> (Socket -> Eff (phoenix :: PHOENIX | eff) a) -> Eff (phoenix :: PHOENIX | eff) Unit
foreign import onMessage     :: forall eff a. Socket -> (Socket -> Message -> Eff (phoenix :: PHOENIX | eff) a) -> Eff (phoenix :: PHOENIX | eff) Unit
foreign import onSocketClose :: forall eff a. Socket -> (Socket -> String -> Eff (phoenix :: PHOENIX | eff) a) -> Eff (phoenix :: PHOENIX | eff) Unit
foreign import onSocketError :: forall eff a. Socket -> (Socket -> String -> Eff (phoenix :: PHOENIX | eff) a) -> Eff (phoenix :: PHOENIX | eff) Unit

-- | Channel operations
foreign import join :: forall eff. Channel -> Eff (phoenix :: PHOENIX | eff) Push
foreign import push :: forall eff. Channel -> Event -> Foreign -> Eff (phoenix :: PHOENIX | eff) Push
foreign import leave :: forall eff. Channel -> Eff (phoenix :: PHOENIX | eff) Push

foreign import rejoinUntilConnected  :: forall eff. Channel -> Eff (phoenix :: PHOENIX | eff) Unit
foreign import canPush :: forall eff. Channel -> Eff (phoenix :: PHOENIX | eff) Boolean

-- | Register callbacks
foreign import onChannelClose :: forall eff a. Channel -> (Channel -> Event -> Eff (phoenix :: PHOENIX | eff) a) -> Eff (phoenix :: PHOENIX | eff) Unit
foreign import onChannelError :: forall eff a. Channel -> (Channel -> String -> Eff (phoenix :: PHOENIX | eff) a) -> Eff (phoenix :: PHOENIX | eff) Unit

-- | Listen for messages on a channel
foreign import on  :: forall eff a. Channel -> Event -> (Channel -> Event -> Foreign -> Eff (phoenix :: PHOENIX | eff) a) -> Eff (phoenix :: PHOENIX | eff) Unit
foreign import off :: forall eff. Channel -> Event -> Eff (phoenix :: PHOENIX | eff) Unit

-- | Push operations
foreign import send    :: forall eff. Push -> Eff (phoenix :: PHOENIX | eff) Unit
foreign import receive :: forall eff a. Push -> Status -> (Push -> Foreign -> Eff (phoenix :: PHOENIX | eff) a) -> Eff (phoenix :: PHOENIX | eff) Push
