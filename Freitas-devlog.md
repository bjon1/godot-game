# Fall 2024 - Intro to Game Design @ SUNY New Paltz
* Name: Michael de Freitas
* [Trello Board](https://trello.com/b/qQN1dU0s/new-paltz-game-design-final-project-template)
* [Proposal](Freitas-proposal.pdf)
* [itch.io](https://mfreit50.itch.io/endless-survival-game)
  
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