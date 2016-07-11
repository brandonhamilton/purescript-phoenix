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
newtype Event
```

#### `newSocket`

``` purescript
newSocket :: forall eff. Endpoint -> Eff (phoenix :: PHOENIX | eff) Socket
```

#### `connect`

``` purescript
connect :: forall eff. Socket -> Eff (phoenix :: PHOENIX | eff) Unit
```

#### `channel`

``` purescript
channel :: forall eff. Socket -> Topic -> Eff (phoenix :: PHOENIX | eff) Channel
```

#### `remove`

``` purescript
remove :: forall eff. Socket -> Channel -> Eff (phoenix :: PHOENIX | eff) Unit
```

#### `join`

``` purescript
join :: forall eff. Channel -> Eff (phoenix :: PHOENIX | eff) Unit
```

#### `leave`

``` purescript
leave :: forall eff. Channel -> Eff (phoenix :: PHOENIX | eff) Unit
```

#### `push`

``` purescript
push :: forall eff. Channel -> Event -> Eff (phoenix :: PHOENIX | eff) Unit
```


