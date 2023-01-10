#!bin/sh

forge script script/DeployBigSky.s.sol:DeployBigSky --fork-url http://localhost:8545 --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 --broadcast

jq < 'broadcast/DeployBigSky.s.sol/31337/dry-run/run-latest.json' | jq -r '.transactions[1].contractAddress' | xclip -selection clipboard 
