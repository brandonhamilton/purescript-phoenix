module Phoenix
  (
    PHOENIX()
  , Socket()
  , Channel()

  , Endpoint()
  , Topic()
  , Event()

  , newSocket
  , connect
  , channel
  , remove
  , join
  , leave
  , push

  ) where

import Prelude
import Control.Monad.Eff (Eff)

-- | The `Phoenix` effect denotes computations which read/write from/to the Phoenix Channels.
foreign import data PHOENIX :: !

-- | A Phoenix Socket
foreign import data Socket :: *

-- | A Phoenix Channel
foreign import data Channel :: *

-- | Phoenix LongPoll Transport
foreign import data LongPoll :: *

-- | Phoenix Ajax Transport
foreign import data Ajax :: *

-- | Phoenix Presence
foreign import data Presence :: *

data ConnectionState = Connecting | Open | Closing | Closed

-- | An Endpoint URL is just a string
type Endpoint = String

type Topic = String

newtype Event = Event String

foreign import newSocket :: forall eff. Endpoint -> Eff (phoenix :: PHOENIX | eff) Socket

foreign import connect :: forall eff. Socket -> Eff (phoenix :: PHOENIX | eff) Unit

foreign import channel :: forall eff. Socket -> Topic ->  Eff (phoenix :: PHOENIX | eff) Channel

foreign import remove :: forall eff. Socket -> Channel -> Eff (phoenix :: PHOENIX | eff) Unit

foreign import join :: forall eff. Channel -> Eff (phoenix :: PHOENIX | eff) Unit

foreign import leave :: forall eff. Channel -> Eff (phoenix :: PHOENIX | eff) Unit

foreign import push :: forall eff. Channel -> Event -> Eff (phoenix :: PHOENIX | eff) Unit