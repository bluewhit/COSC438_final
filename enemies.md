# Enemies

## slime: sprites 64, 65 
	chases after the player faster once seen, does damage on touch. 
	if player is not "seen" it wanders around slowly.  

## snake: sprites 66, 67
	similar to slime

## skull: sprites 90, 91 
	skull slowly follows the player, gains speed after chasing
	damage on touch
	still until it sees a player

## shadow slime: sprites 69,70,71
	stays in place
	when player moves within certain amount of spaces it will move either
	horizontally or vertically back and forth. 
	damage on touch 

## shadow creature: sprites 72, 73 
	moves after the player slowly 
	wanders around the room randomly until the player moves within radius
	will stop chasing player if they escape radius
	damage on touch

## eyeball: sprites 74, 75 
	floats up and down, maybe i'll add a shadow underneath it
	i *think* i'll add another sprite for when the player is above the eyeball
	does not have a "large" chase radius, will give up following quickly
	ranged attack, i was thinking a 3 "bullets" that are 1x1 pixel will 
	"shoot" at the player
	damage on touch and if the bullets make contact 

## blood monster: sprites 76, 77, 78, 79 
	sits still on sprite 77
	when player enters chase radius it will do damage on contact
	fast intial burst after player in a straight line, but slows down 
	and tries attack again. kinda like "dashing"

## spikes: sprites 80, 81 
	pop out of ground on a loop
	damage on contact
	stationary. 

## flame: sprites 86, 87 
	shoots sprite 85, it's a "small" fireball.
	damage on contact 
	hops around the map occasionally, but does not chase the player.

# Mini-Bosses 
	
## grim reaper: sprites 95 
	does not chase the player
	will attempt to run away if the player gets close
	floaty boy
	his scythe will chase the player in a floaty fashion
	sythe does damage on contact
	dunnno if touching him should damage or not 

## tik tok clok: sprites 88 
	attacking tbd

## rotting fish: sprites 160, 162 
	flops around, so slow moving.
	randomly flops towards player
	uses a "bubble" for a ranged attack. 
	maybe make it "rain" lol

## flaming bat: sprites 140, 142, 172
	shoots regular flames
	shoots blue flames that do xtra damage
	flies around kinda randomly after attacking
	its on fire so might hurt to touch it
	only flames when it is randomly flying around 
	when it is about to attack the flames go down 
	touching it is ok when it has no flames 
	* note i need to add another sprite for it 

# mr. nightmare: sprites 128, 130, 132
	hands pop up, max like 3 hands. the hands will wiggle
	then plop down to sprite 130, if the player is in the radius
	they will take damage. think of it kinda like a mini earthquake.
	mr. nightmare stays stationairy for the most part, but 
	may slowly move around the map after attacking
	uses blue flame as a ranged attack (recolored fire sprite, ill do that)
	may spawn 1-2 small shadow enemies
	any extra attacks?? 

** all of these are suggestions, please change as u wish! :)   
 


