pragma solidity ^0.7.0;

import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/token/ERC721/ERC721.sol";

contract MyToken is ERC721 {
  // 定义您的代币名称和符号
  string public name = "Xman NFT Token";
  string public symbol = "XMNT";

  // 定义您的代币拥有者
  address public owner;

  // 定义您的代币构造函数
  constructor() public {
    // 将代币拥有者设置为合约创建者
    owner = msg.sender;
  }

  // 定义您的代币分配函数
  function mint(address _to) public {
    // 分配一个新的代币给指定的地址
    _mint(_to, totalSupply() + 1);
  }

  // 定义您的代币转移函数
  function transferFrom(address _from, address _to, uint256 _tokenId) public {
    // 检查操作者是否有权限转移代币
    require(msg.sender == owner || _from == msg.sender);
    // 转移指定的代币
    _transferFrom(_from, _to, _tokenId);
  }
}
