# imsg

Tired of getting off your terminal screen to answer those friends of yours?
Now you can contact them right from the terminal!

## Installation

It is easy as:

```bash
$ gem install imsg
```

## Usage

### View current imsg commands
```bash
$ imsg
```

    Commands:
      imsg chat            # Send a new message to an existing chat
      imsg chats           # Shows your current chats
      imsg help [COMMAND]  # Describe available commands or one specific command
      imsg message         # Send a message to a buddy

### Send a message to a buddy and get the chat list
```bash
$ imsg message "hello from the terminal"
```

Then select a buddy corresponding to the person you wish to message

    1 - Christian Sampaio
    2 - Linus Torvalds
    3 - Tim Berners Lee
    4 - Steve Wozniak
    5 - Sergey Brin
    6 - Larry Page
    To whom would you like to send this message to?

```bash
$ Christian Sampaio
```

### Send a message to a known buddy without list
```bash
$ imsg message "hello from the terminal" -b 'Christian Sampaio'
```

### Send a message to a chat and get the chat list
```bash
$ imsg chat "hello from the terminal"
```

Then select a chat number corresponding to the chat you wish to message

    1 - Christian Sampaio
    2 - Linus Torvalds
    3 - Tim Berners Lee
    4 - Steve Wozniak
    5 - Sergey Brin
    6 - Larry Page
    Which chat would you like to send this message to?

```bash
$ 4
```

### Send a message to a known chat without list
```bash
$ imsg chat "hello from the terminal" -n 1
```

### View current chats
```bash
$ imsg chats
```

    1 - Christian Sampaio
    2 - Linus Torvalds
    3 - Tim Berners Lee
    4 - Steve Wozniak
    5 - Sergey Brin
    6 - Larry Page

### View current chats with limit
```bash
$ imsg chats -l 1
```

    1 - Christian Sampaio

### Not having write permissions:
If you don't have write access to your Ruby folder:

```bash
$ sudo gem install imsg
```

## Contributing

1. Fork it ( http://github.com/chrisfsampaio/imsg/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Contact

christian.fsampaio@gmail.com
http://chrisfsampaio.github.io

#<3
