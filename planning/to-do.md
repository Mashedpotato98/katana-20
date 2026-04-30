
###### THE HITBOX, HURTBOX AND ATTACK THINGIES ARE ALL MESSED UP. DONT TRY TO FIX IT, REDO IT 
##### THE MELEE WALL COLLISION THINGIE DOES SOME BAD STUFF, KEEP THAT IN MIND


Coding: 
  player: 
    > (D, but its still  a bit of a mess. Need to connect and disconnect signals when enterting and exiting state)the mess of signals in the player state machine. Need to make it readable. Even the old system might've been
    better with checks for current state

    > (Yeah, dependancy injection is probably not helping) The mess of variable assignment in the state machine. Dependancy injection might help
    but I have no idea

    > (Looks good, might use it) Experiment with using a tween for the melee charge instead of physically moving the player using its velocity

    > (D, done. ROught) Stopping the player before hitting a wall during the charge attack. Or doing something else that does not reduce the fun when acidentally hitting walls during the melee attack

    > (D, but dont know about the side effects) Time slowing down during melee charge -> Side effect: Sometimes when slowing time just before dying, the next run of the game is choppy

    > The melee ray indicator should not go trhough walls. Rather, it should stop before intersecting with a wall

    > (D, very messy still)_ There are some problems with the player collision, particularly in the melee collision 

    > (D, roughy) The player should be using a hurtbox and hitbox. Since, we need to disable stuff based on that. One hitbox and hurtbox for now, might changei nthe future

    >(D, Janky, for now. Feels nice) Maybe, instead of changing movement by velocity, directly change position in melee 

    >Maybe the player should instantly change positions in dash melee

    >(OOh, I think it maybe working) Maybe, the player has two melee attacks. One is the dash attack and the other is a regular melee attack 

    > (D, but maybe no in this way) Maybe the player can move around a bit when grappling. A bit of horizontal motion

    > (D) quick melee pushes the player in the direction of the mouse

    >Right now, without a cooldown timer, the player can just float in the air using the quick melee. I am using a cooldown timer to stop it but I think its less satisfying ni this way.
    Maybe after a certain number of quick melees done by the player, there's a secret cooldown

  enemies: 
    > (D, a basic version has been done. Problem is the area for detecting whetehr the player is close and the hit-box is the same) The strong terry attack state. Terry will get close the player and attack


      > Sniper enemy:
          >
        
  general :
    > Improve the look at of ray component for a smoother and more realisitci look at, not lock on

level:    
  > A proper level management thingie. I need to decide on how big a level should be, whether and how many mini-levels there should be in a level, how big each mini-level should be, etc
  > Add some new stuff like lasers or other obstacles. I need them to get ideas for levels. -> MOST IMPORTANT

  > A proper level 

hud :
  > Need to make a proper hud with elegant code

Planning and organizing :
  > Need to organize my files 


ART :
  > Player Sprite
  > Terry sprite
  > Sniper Sprite
  
