pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";

// 定义代币名称
string public constant name = "XmanToken";
// 定义代币符号
string public constant symbol = "XMT";
// 定义代币精度
uint8 public constant decimals = 18;
// 定义国库地址
address public treasury;
// 定义每日分红比例
uint256 public dividendPercentage = 50;


// 继承ERC20智能合约
contract XmanToken is ERC20 {
    // 定义卖出手续费率
    uint256 public sellFee = 2;

    // 定义构造函数，用于初始化代币
    constructor(address _treasury) public {
    // 将代币发行给合约创建者
    _mint(msg.sender, 100000000 * (10 ** uint256(decimals)));
    treasury = _treasury;
    }

    // 定义给定用户增加代币的函数
    function mint(address account, uint256 amount) public {
        // 增加给定用户的代币数量
        _mint(account, amount);
    }

    // 定义买入代币的函数
    function buy() public payable {
        // 计算买入量
        uint256 buyAmount = msg.value / (1 ether / (10 ** uint256(decimals)));
        // 为买家增加代币
        _mint(msg.sender, buyAmount);
    }

    // 定义卖出代币的函数
    function sell(uint256 amount) public {
        // 计算卖出量
        uint256 sellAmount = amount * (1 - sellFee / 100);
        // 为卖家增加Ether
        msg.sender.transfer(sellAmount * (1 ether / (10 ** uint256(decimals))));
        // 减少卖家的代币数量
        _burn(amount);
    }

    // 定义接收交易手续费的函数
    function receiveFee(uint256 amount) public {
        // 将手续费发送到国库地址
        treasury.transfer(amount * sellFee / 100 * (1 ether / (10 ** uint256(decimals))));
    }

    // 定义卖出代币的函数
    function sell(uint256 amount) public {
        // 计算卖出量
        uint256 sellAmount = amount * (1 - sellFee / 100);
        // 为卖家增加Ether
        msg.sender.transfer(sellAmount * (1 ether / (10 ** uint256(decimals))));
        // 减少卖家的代币数量
        _burn(amount);
        // 接收手续费
        receiveFee(amount);
    }

        // 定义计算用户持币数量的函数
    function balanceOf(address account) public view returns (uint256) {
        // 返回用户的持币数量
        return balances[account];
    }

    // 定义每日分红的函数
    function distributeDividend() public {
        // 获取代币总量
        uint256 totalSupply = totalSupply();
        // 获取所有持币人的地址
        address[] memory holders = getHolders();
        // 循环所有持币人
        for (uint256 i = 0; i < holders.length; i++) {
            // 计算该持币人的持币比例
            uint256 percentage = balanceOf(holders[i]) / totalSupply;
            // 计算该持币人的分红量
            uint256 dividend = totalSupply * percentage * dividendPercentage / 100;
            // 为该持币人增加分红量
            _mint(holders[i], dividend);
        }
    }
}
