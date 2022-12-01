## BigSky 


https://user-images.githubusercontent.com/77446076/205087423-01516b7d-18d8-4087-8530-4d07652f77fe.mov

BigSky is an ethereum based developer game.  Players compete by programming the logic for individual space-ships.  When a player launches a ship, their ship design is submitted to the master contract.  The master contract then runs the ship logic againgst a randomly generated scenario.  The goal of the ship is to collect as many stars as possible. 

Example ships can be found in the 'src/ships' folder.

### Status

BigSky is full playable with all basic game mechanics in place.  This project is still in heavy development.  Expect multiple iterations on the core smart contracts over the next month.

### Installation

Make sure you have Foundry installed.  

Clone the repository into the folder of your choice.  

```sh
gh repo clone bigsky77/bigsky-contracts
```

Compile and test the codebase.

```sh
Forge Build
Forge Test -vvv
```

To deploy a local development version of the contracts.  

```sh
forge script script/DeployBigSky.s.sol:DeployBigSky --fork-url http://localhost:8545  --private-key<YOUR_PRIVATE_KEY> --broadcast
```

### How to Play

BigSky can be played either on the platform's native website [bigsky.gg](bigsky.gg) or by using your favorite block-explorer.

Following the sample ship example.  Program any set of move's for your ship.  Every turn your ship will take those moves following any logic that you have written in the Ship contract.  You can write tests for your ship by using the '/test' folder. 

Once you are ready deploy your ship to the TBD block-chain.  Make sure you pass the address for the BigSky contract into your ship's constructor.





