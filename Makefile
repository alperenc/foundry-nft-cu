-include .env

.PHONY: all build test test-forked deploy deploy-sepolia

install:
	forge install ChainAccelOrg/foundry-devops --no-commit && forge install OpenZeppelin/openzeppelin-contracts --no-commit && forge install foundry-rs/forge-std@1.8.2 --no-commit

update:; forge update

clean:; forge clean

build:; forge build

test:; forge test -vvvv

test-forked:; forge test --fork-url $(ALCHEMY_SEPOLIA_RPC_URL)

deploy:;

deploy-anvil:
	forge script script/DeployBasicNft.s.sol:DeployBasicNft --rpc-url http://127.0.0.1:8545 --account anvil_0 --broadcast -vvvv

deploy-sepolia:
	forge script script/DeployBasicNft.s.sol:DeployBasicNft --rpc-url $(ALCHEMY_SEPOLIA_RPC_URL) --account metamask_2 --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv

mint-sepolia:
	forge script script/Interactions.s.sol:MintBasicNft --rpc-url $(ALCHEMY_SEPOLIA_RPC_URL) --account metamask_2 --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv