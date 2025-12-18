# jank-tools

a collection of utterly useless but highly entertaining linux cli tools.

## tools

### gman (c)
the g-man from half-life, in your terminal. cryptic quotes delivered with dramatic pauses.
```bash
gman                    # random quote
gman --hire             # employment offer
gman --consequences     # unforeseen consequences
```

### paint (c)
watch paint dry. customizable duration and color.
```bash
paint                   # 30 seconds of paint drying
paint -h 2 -m 30 -s 5   # 2 hours, 30 minutes, 5 seconds
paint -color red        # watch red paint dry
```

### iamspeed (c)
animated "i am speed" text that bounces. ctrl+c to stop.
```bash
iamspeed
```

### meme printers (c)
one-liner memes:
- `cheese` - to cheese or not to cheese
- `delay` - stop procrastinating
- `me` - you
- `you` - me
- `panic` - OH NO OH NO
- `oh` - what?
- `why-does-this-exist` - because it's fun lol

### manmanman / manmanmanman (c)
meta man pages. manuals about manuals about manuals.
```bash
manmanman       # manual for your man manual
manmanmanman    # we must go deeper
```

### grok-is-this-true (rust)
random yes/no oracle. 90% says no. detects elon musk in input.
```bash
grok-is-this-true
echo "elon musk is cool" | grok-is-this-true   # always yes
```

### make-a-file (rust)
creates a random file with a random extension in your current directory.
```bash
make-a-file     # creates something cursed
```

### mandela (rust)
gaslights you about a file that doesn't exist in your directory.
```bash
mandela         # wake up
```

### btw (go)
"i use arch btw" but detects your actual distro.
```bash
btw             # i use <your-distro> btw
```

### surprise (go)
pick a card, any card. probably wrong but might be right.
```bash
surprise
```

### maybe (go)
50/50 chance of running a command.
```bash
maybe ls        # might list files, might not
maybe rm -rf /  # don't actually do this
```

### spellaword (c++)
spells a random word letter by letter with 0.5s delays.
```bash
spellaword
```

### bedtime (c++)
sleepy sounds. either "honk shoo" or "snore mimimimimimi".
```bash
bedtime
```

---

## building

### requirements
- gcc (for c)
- g++ (for c++)
- rustc (for rust)
- go (for go)
- make

### compile
```bash
make              # compile all tools
make clean        # clean compiled binaries
sudo make install # install to /usr/local/bin
sudo make uninstall # remove from /usr/local/bin
```

## contributing

got a stupid idea for a jank tool? open a pr. the more useless, the better.

## license

do whatever you want idk lmao

## credits

made by someone who probably should've been doing something productive instead

powered by: coffee, adhd, and the resonance cascade
