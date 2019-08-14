# Game-Design-Workshop

A few one-week prototypes from my grad game design workshop course back in January-May 2016. During this, we were also working 
on our thesis project for the course where we researched [alternative uses for crafting in games.](https://github.com/chillen/Action-Crafting)

Each week, we were presented with a theme and given one week to accomplish one of three tasks:

1. Write a short (2-4 pages) design pitch for a toy / game, researching other similar designs, prototype it in Processing, 
and present your game for discussion.
2. Write a more in depth design pitch for a more complex game, with lots of research on similar designs
3. Thoroughly play and review the prototypes developed last week.

It was my first grad course, and taken while doing 4 other undergrad courses! A lot of fun, but you get left with 
pretty minimal time. I've included some of the prototypes that were built. 

## Five Days to Grow

**Theme:** Nurturing Plants.

**Description:** Five Days to Grow is a game about uncovering which traits affect your plants growth before time runs out! 
Look at other gardener's examples to grow the ideal plant.

On day one you are presented with a target plant with three traits: Flavour, size, and shape. Each of these is associated with
the appearance of the plant in some way. Each day you can adjust either the soil, water, or light exposure. You're presented
with another botanist's plant and their growth conditions. Within five days, you have to identify which traits associate
with which conditions and grow the ultimate plant!

![Five Days to Grow Gameplay](#todo)

**Critiques:** The main critique is replayability. There isn't any replayability. While the traits can be randomized,
and the objective is changing, once you figure out the easy objective you stop making meaningful choices and begin to 
follow a flowchart. This is the issue with the original *Mastermind* as a game is that it isn't replayable, but more 
a useful tool to teach logical deduction. With that in mind, this theming works pretty well for these mechanics and could
be thrown in as a mobile mini-game similar to how [*TAP! DIG! MY MUSEUM!*](https://play.google.com/store/apps/details?id=jp.oridio.museum&hl=en_US) makes use of
a simple Battleship mechanic to progress an idle game. 

The other big critique I have is player information. The prototype, as it stands, hides previous findings from the player. 
This just encourages notetaking, which breaks the player from their immersion. With traits slowly uncovering, more information
is revealed, and the player should be able to make more informed decisions without relying on notetaking. This raises an issue 
for the previous expansion, though: rules have to be randomized each game. This means the theming would have to somehow 
offer a reason that A. The botanist in question is constantly relearning botany, and B. The rules of botany change. Perhaps 
this is solved by having an alien planet, or by having a much more rich space of experimentation, in the style of Alchemy -- 
perhaps the player isn't making a "Big, sweet" thing, but instead trying to brew potions with interesting interactions and effects
on the one consuming it.

## Dim Light

**Theme:** Freezing to Death.

**Description:** You wander into the dark unknown, passing by others who have taken the same journey. They ask you for help retreating -- 
but where does that leave you? Would it even help them make it out alive? 

In Dim Light, you move to the right and control the amount of light coming off of your lantern. The brighter your lantern, the warmer
you become and the more you can see. You stumble upon people who ask for food or oil to keep warm and make it out alive while you
move ever further into the caves. 

![Dim Light Gameplay](#todo)

**Critiques:** There really isn't a lot of gameplay here, with the theme bringing up feelings of depression and hopelessness.
The player isn't making any *really* meaningful choices, even if it might seem like it, since the outcome is "Die now or die later".
The gameplay is heavily inspired by the outstanding [ALZ](https://www.newgrounds.com/portal/view/634905) and a few others I'm having
a hard time recalling. It doesn't quite work as a prototype, and the core play doesn't feel great. Obviously the player
needs more objectives or at least a more motivating force to make it to the end. With some proper environmental storytelling,
maybe this could be reworked into a 3 minute interactive experience.

## Dungeon Master

**Theme:** Indirect Control over Movement.

**Description:** Oh no. The party is heading for a total-party-kill. If they just go through the right door they'll be able to get the
tower shield... 

*Fighter:* I'm getting ancy for a fight. Do I hear any monsters?
*DM:* Uhh... Roll perception. **phew** You hear growls and snarls coming from... **The door on the right.**

In Dungeon Master, you take on the role of a DM with a varied group of adventurers playing a tabletop role-playing game.
Each party member has a set of personality attributes (greedy, aggressive, defensive, etc.) and stats for combat. The game 
map has various entities (traps, useful items, keys, and monsters). The only way to interact with the party is to carefully
describe the map for them and hope that you can appeal to their senses to convince them to go the right direction without getting
wiped out. Guide them to keys, important items, and protect them from harm as best as you can before they make it to the big bad.

![Dungeon Master Gameplay](#todo)

**Critiques:** I really think this was a cool idea, but the execution wasn't great. The basic idea of *appealing to* NPC personalities
as your primary interaction was reworked into my [honour's project](#todo) making use of symbols rather than phrases. Phrases
are far too cumbersome and repetitive, particularly for something best suited for a mobile game with little screen real estate.

The next critique is the lack of feedback. Right now, you effectively say "Go right" and they either go right or don't go right.
It isn't making use of the personalities enough, and certainly isn't showing the player how it makes use of personalities at all.

If I were to reinvent this, I'd focus on the characters more than the map and progression. Generate interesting descriptive texts
as they enter a room, slow things down, make use of simulated simple combat similar to [Soda Dungeon](https://store.steampowered.com/app/564710/Soda_Dungeon/)
and offer offer a few decisions to the DM rather than giving them a big checklist. 

As an interface, I'd probably convert this into a card game of sorts and force the DM to explain everything in the room. Perhaps
they only explain what they want, and if they leave too much out the party gets inquisitive and requests more information. I 
really wanted a kind of casual dungeon master simulator. I was docked points for not appealing to a broader audience, but you know what,
sometimes DMs need an outlet, too :)


## Dungeon Master

**Theme:** The Weather. (Player choices are governed by "weather", a somewhat chaotic system with an overlooming climate)

**Description:** QUICK! The undead are rising, and adventurers are making their move for riches and glory! 
Put the holy symbols on sale. *Not too much!* We're out to make a profit, you know. 

ShopKeep is a game where you *exclusively* run a shop, collecting rumours from adventurers who come by to try and figure out
the best items to stock. They come to you with stories, they describe their battles, and they sell you their junk. It's up to you
to track sales and sort out who is going to make it out on top.

![Shop Keep Gameplay](#todo)

**Critiques:** I really love NPC manipulation games. It's a running theme. Unfortunately I wasn't able to get those mechanics
into the prototype. At the moment, the game's pretty random but doesn't punish you very hard for not catching on to the big bad.
It just doesn't give you enough meaningful input as to how you should be stocking your wares and gives you a *ton* of choice for
which items to stock right away. 

I'd hoped to make the selling phase more like a turn-based RPG where you could chat with the customers, haggle, and act as a salesman.
Whereas a lot of the other merchant games I've seen focus on going out into the dungeons to get loot and sell it, I really wanted
the core dynamics to be about foresight and charisma. These don't really come across, though. The player needs to be able to obtain more
information -- at the expense of some other resource -- and alter the NPCs perspectives in some way. They should be able to make informed
day-to-day decisions, rather than just playing blind and slowly learning the overall distribution of big bads. 

Similar to the issues with *Five Days to Grow*, the player needs a history of their previous interactions to understand 
how to stock optimally. Unlike Five Days, this information can be presented a little more abstractly. I really like the 
mindmap styled quest log/codex in [Pathalogic 2](https://store.steampowered.com/app/505230/Pathologic_2/). If the player
had far more ways to get information, and the core loop focused on information exchange, then there could easily be room
for the player to examine a mindmap of collected information and try to puzzle out trends.

Pushing the player to conversational analysis, giving them more day-to-day feedback to prep them for the next day, and 
letting them give messages to the NPCs to adjust *their* behaviour might be the route to salvaging this.
