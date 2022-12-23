# Byzantium

> What the hey is this?

It's the first full-fledged programming project I ever worked on. This dates back to
my final summer in high school during 2010. Recently, a friend reminded me of this project's
existence. So, I've decided to dig it up and publish as a fun little artifact to
look back on and remind me of where I started my software development journey.

> But really, what is it?

This is a prototype for what would have been a tactical role playing game much
like Fire Emblem is today. Specifically, it was inspired by Tactics Ogre, a series
beloved to a friend of mine at the time. Since the series was dormant we decided to try and
create a spiritual successor in the form of a Flash game. I would do the programming
and my friend would do the writing... we didn't have the art bit sorted out.

Any ways, our ambitious, teenage selves wanted to build this epic game and publish
it on Newgrounds. That, of course, never happened. However, it was neat to predict the
revival of such games! (But not the death of Flash. RIP)

> Cool! Can you tell me how it was built?

The code is written in ActionScript and uses a then-popular game engine called
Flixel. I used the [FlashDevelop](https://www.flashdevelop.org/) IDE.

Everything is divided up into classes under [./src](./src):

* `Actor` - This describes warriors used in battle.
* `Basic` - A class which contains some common metadata for different game entities.
* `CityState` - This game was meant to have a global politics mechanic where small countries could form allegiances and rivalries with each other. This was a container for that.
* `Demo9` - The (poorly named) battle system implementation.
* `HomeBase` - Essentially a shop for in-between battles.
* `Main` - Entrypoint for the game.
* `OverWorld` - A large map where you interact with city states, shop, and go into battle.
* `Prop` - Your classic RPG items.

Be wary, there are _a lot_ of if-statements in this code.

> Can I play it?

The prototype is extremely rudimentary. Basically just a battlefield with a
warrior for each party present. It's meant to test out basic mechanics like fighting,
talking, casting spells, using items, etc.

Of course, this is built on Flash which is dead now. You're more than welcome to run it on an emulator. Keep in mind 
you'll also need a copy of the Flixel library.

> Why "Byzantium"?

The game was going to take place during the time of the Byzantine Empire. It was actually going to be very story heavy,
involving a lot of fantasy and time travel elements.

> Any plans to pick this up again?

Probably not. On the one hand: I don't spend much time coding in my freetime these days. And on the other hand: the 
achiever in me would like to see this realized some day.

> What takeaways did you have from working on this?

Since it was my first serious project, I learned A LOT about computer programming,
specifically, Object Oriented Programming. That, of course, isn't in vogue these
days but the exercise of structuring the data and writing algorithms set the tone
for the rest of my career.

> Anything else worth mentioning?

I shamefully admit this is not a pristine archive. I've removed a few old comments
that were hilarious to me at the time but make me cringe now (remember, I was a
teenager). That's about all I've changed.

In addition to this source code, there was a visual novel engine I wrote that
was supposed to be used in the game. But that unfortunately seems to be lost now.

That's all. Enjoy this little time capsule!
