### Ten Things I wish I knew when starting a large project 
  > Don't blindly follow every tutorial. No tutorial is one size fits all, take them as a blueprint

  > Sprite offset vs position:
      When lining up the sprite with, lets say, a sprite, dont change the position, change the offset of the sprite. 

  > Give player character a god mode: 
      Gonne be very easy to debug.   
      Though, to be honest, playing different parts of the game might help you find rare bugs. 
      
  > Don't flip nodes with x-scaling
      No x * -1 lil bro
      When you scale a node, all the child nodes get affected.
      Solutions : Use sprite.flip_h for visuals OR explicitly reposition physics nodes OR store two local positions or transforms and swap between them.

      Takeaway - Dont let visual conveniences dictate physics truth

  > Don't use preload for something that is not reusbale #Research more about this.

  > Use Visual On screen notifiers for enemies. Btw, the visibly_nodes require 

  > Choose correct aspect ratio and scaling settings 

  #### Quick Tips:
    > In the editor, alt+right click lets you choose exactly what object you wanna pick 
    > If your fonts look blurry, enable msdf
    > You can mark files and folders favourites in the file system 

#Random guy's thoughts -> For the first and third one, I think you took away the wrong lesson. You SHOULD be able to freely transform Sprites without breaking other things.
That way you can create procedural animations using transformations (squish/stretch, shake, etc.). 
The correct lesson is you should NEVER add technical/non-visual nodes as children to visual nodes. 
i.e. collision boxes should hold sprites, instead of sprites holding collision boxes.
