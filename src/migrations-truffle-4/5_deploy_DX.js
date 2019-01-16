function migrate ({
  artifacts,
  deployer,
  network,
  accounts
}) {
  const DutchExchange = artifacts.require('DutchExchange')
  const DutchExchangeProxy = artifacts.require('DutchExchangeProxy')

  return deployer
    // Deploy DX and it's proxy
    .then(() => deployer.deploy(DutchExchange))
    .then(() => deployer.deploy(DutchExchangeProxy, DutchExchange.address))
    .then(() => console.log('SETUP 5 DONE'))
}

module.exports = migrate
