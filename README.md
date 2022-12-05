# base-contract v1.0 
## Openzeppelin base-class for universal smart contracts development.
This is a set of methods that will be useful for any smart contract project. Basically boiler-plate Solidity code for smart contract developers.

- Uses open zeppelin Contracts Wizard: https://docs.openzeppelin.com/contracts/4.x/wizard

Very easy to use, basically all that you have to do is to inherit from BaseContract.sol and you should have everything you need built-in, just use the `super` keyword to access the base class methods and you are good to go.

By default, this will inherit from:
```
ERC721, ERC721Enumerable, Pausable, Ownable, ERC721Burnable
```

## Example

```solidity
// SPDX-License-Identifier: MIT

import "./IBaseContract.sol";

pragma solidity ^0.8.9;

contract ExampleContract is BaseContract {
    constructor() BaseContract() {} 
}
```

enjoy! 🚀
