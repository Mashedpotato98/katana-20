
Coding: 
  player: 
    > (D, but its still  a bit of a mess. Need to connect and disconnect signals when enterting and exiting state)the mess of signals in the player state machine. Need to make it readable. Even the old system might've been
    better with checks for current state
    > The mess of variable assignment in the state machine. Dependancy injection might help
    but I have no idea
    > Experiment with using a tween for the melee charge instead of physically moving the player using its velocity
    > Stopping the player before hitting a wall during the charge attack. Or doing something else that does not reduce the fun when acidentally hitting walls during the melee attack

  enemies: 
    > (D, a basic version has been done. Problem is the area for detecting whetehr the player is close and the hit-box is the same) The strong terry attack state. Terry will get close the player and attack

level:    
  > A proper level management thingie. I need to decide on how big a level should be, whether and how many mini-levels there should be in a level, how big each mini-level should be, etc
  > A proper level 


hud :
  > Need to make a proper hud with elegant code
