pragma solidity ^0.8.0;

interface IERC20{

    function totalSupply() external view returns(uint256);
    function balanceOf(address owner) external view returns(uint256);
    function transfer(address to,uint256 value) external returns(bool);
    function transferFrom(address from,address to,uint256 value)external returns(bool);
    function approve(address spender,uint256 value)external returns(bool);
    function allowance(address owner,address spender)external view returns(uint256);

    event Transfer(address from,address to,uint256 value);
    event Approval(address owner,address spender,uint256 value);

}