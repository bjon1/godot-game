### 2024-10-29 - 1hrs: Increased difficulty
* Now every 10 levels a Boss spawns (different color, larger, more health, slower)
* Every player level increase, enemies get 10 more health
  
### 2024-10-22 - 2hrs: New controls and HUD improvements
* Player can now switch weapons with number keys "1" and "2" instead of only scroll wheel
* Health bar now displays max health along with current health
* The game over screen now displays a final score when the player is destroyed
  
### 2024-10-19 - 4hrs: Upgrade limits, game over screen, and bug fixes
* Fixed xp from leveling up player too fast before game pauses
* Some upgrades now have a limit indicated by a check box on the left
* Game over screen has a "quit" and "restart" button
* Weapons can no longer attack when game is paused

### 2024-10-18 - 6hrs: Upgrade system revamped
* Upgrade buttons are now individual scenes
* Upgrade buttons are added and removed from one dictionary to handle all upgrades
* Fixed bug with capitalization mismatch
* Limited fire rate upgrade to decrease by 0.2 seconds

### 2024-10-16 - 3hrs: Made enemies chase player & leveling up pauses the game
* Game now pauses with Engine.time_scale = 0 as opposed to disabling movement
* Enemies have a vector that points toward the player and spawn every second on a random path location
* Enemies also avoid each other by subtracting the vectors of close enemies 

### 2024-10-14 - 6hrs: Upgrade menu changes and bug fixes
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
* Watched video on enemy item drops (https://youtu.be/-ep3ARuCdk0?si=gLV5ln3cJLgYsC7U)
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

