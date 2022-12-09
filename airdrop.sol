// 定义xman系列NFT的合约地址
address public nftContract;

// 定义xman系列NFT的符号
string public constant nftSymbol = "XMAN";

constant airdropNft{
        // 定义构造函数，用于设置xman系列NFT的合约地址
    constructor(address _nftContract) public {
        nftContract = _nftContract;
    }

    // 定义空投xman系列NFT的函数
    function airdropNft(address account) public {
        // 获取xman系列NFT的合约
        ERC721 token = ERC721(nftContract);
        // 获取xman系列NFT的随机数量
        uint256 randomNumber = uint256(keccak256(abi.encodePacked(account, now)));
        // 获取xman系列NFT的随机ID
        uint256 randomId = randomNumber % token.totalSupply();
        // 将xman系列NFT随机ID的代币转移到指定地址
        token.safeTransferFrom(msg.sender, account, randomId);
    }

    // 定义获取xman系列NFT的函数
    function getNft() public {
        // 获取用户的代币数量
        uint256 balance = balanceOf(msg.sender);
        // 判断用户是否持有代币超过千分之一
        if (balance > totalSupply() / 1000) {
            // 给用户空投xman系列NFT
            airdropNft(msg.sender)
        }
    }
}

