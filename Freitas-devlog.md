### 2024-9-21 – 3hr worked on destructible tile maps 
* tile maps noew have the ability to be destructed when given normalized collision coordinates

### 2024-9-22 – 3hr worked on a base gun class 
* guns now inherit from a base class which establishes its functionality 
* added and credited assets for weapons

### 2024-9-24 - 2hr worked on gun resources
* Moved all variables and utility funcitons for a weapon to a resource with getter and setter methods
  
### 2024-9-26 – 4hr worked on state machines for gun class 
* Added State machines (idle, shoot, reload) to weapons using enums

### 2024-9-28 – 6hr worked on explosion mechanic for tile map
* Created a system where tilemaps can explode given a blast radius using geometry of a semi-circle (original algorithm)

### 2024-10-20 - 1hr worked on a script to generate block sprite sheets
* A python script that when given a tile, will generate breaking effects depending on the tile's durability and create a sprite sheet out of it

### 2024-11-21 - 4hr worked on procedural generation
* Added procedural generation as a game mechanic
* Procedurally generated tiles are destructible
* Used tutorial (https://www.youtube.com/watch?v=rlUzizExe2Q&pp=ygUbcHJvY2VkdXJhbCBnZW5lcmF0aW9uIGdvZG90)

### 2024-11-26 - 6hr worked on a chunking system
* Created a hashset data structure for godot
* Created a system to divide subsects of the world into a chunk coordinate
* Created a system that keeps track of loaded chunks in the world
* Created a system that can load chunks depending on render distance