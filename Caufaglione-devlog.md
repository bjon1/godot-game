### 2024-10-14 - 6hr Upgrade menu changes and bug fixes
* Reworked upgrade menu to grab three random upgrades choosing from (Player upgrades, Sword upgrades, or Pistol upgrades)
* Fixed bug with XP, XP would start vibrating if the player moved faster then the XP
* Added a new weapon menu when level 5 is reached

### 2024-10-08 - 2hrs: worked on basic upgrade interface 
* When a new level is reached three buttons pop up to give the player a choice of possible upgrades (increase sword size, damage, or pickup radius) 

### 2024-10-07 - 1hr: work on xp shader and added damage to sword 
* Asked chatgpt to make a shiny glowing shader that is like minecraft xp, Then tinkered around with the parameters till it looked right. 
* Also, looked into base bullet class and base enemy class to figure out how to make the sword deal damage 

### 2024-10-06 - 1hr: worked on level up system
* Added a basic level up system with 100xp for level one and plus 10xp for each new level
* A UI controller attached to the character updates every frame
  
### 2024-10-04 - 3hrs: working on xp drop and pickup 
* Watched video (https://youtu.be/-ep3ARuCdk0?si=gLV5ln3cJLgYsC7U)
* Created an xp consumable that drops randomly when an enemy is eliminated. 

### 2024-10-03 - 1hr: worked on progress bars 
* Watched two videos to create Hp and Xp progress bars (https://www.youtube.com/watch?v=5poF352bDsQ) and (https://www.youtube.com/watch?v=1gHMG_WuDZY)
  
### 2024-10-01 - 4hrs: worked on base sword class
* Added swing animation and hitbox
* Added functions for upgrading speed and size

### 2024-09-29 - 2hrs: worked on weapons and weapon switching
* Added a pistol and shotgun weapon
* weapons can be selected with the mouse scroll wheel
* Fixed bullets colliding with player 

### 2024-09-25 - 2hrs worked on player controller
* Asked chatgpt how to always get the main scene node
* var first_node = get_tree().root.get_child(0)
* Added simple animation for idle and walk

