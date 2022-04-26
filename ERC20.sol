// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./IERC20.sol";

contract ERC20 is IERC20{

    string public name = "MYTOKEN";
    string public symbol = "MFT";
    uint256 public decimals = 8;
    uint256 public _totalSupply;

    mapping (address=>uint256) private _balances;
    mapping (address =>mapping(address=>uint256)) _allowed;


    function totalSupply() public view override returns(uint256){
        return _totalSupply;

    }
    function balanceOf(address _owner) public view override returns(uint256){
        return _balances[_owner];

    }
    function transfer(address to,uint256 value) public override returns(bool){
        require(to != address(0),"not a valid address");
        require(value <= _balances[msg.sender],"didn't have a sufficient value");

        _balances[msg.sender] -= value;
        _balances[to] += value;
        emit Transfer(msg.sender,to,value);
        return true;
    }
    function transferFrom(address from,address to,uint256 value)public override returns(bool){
        require(to != address(0),"not a valid address");
        require(value <= _balances[from],"owner havnt enough balance");
        require(value <= _allowed[from][msg.sender],"spender havn't enough balance");

        _balances[from] -= value;
        _balances[to] += value;
        _allowed[from][msg.sender] -= value;
        emit Transfer(from, to, value);

        return true;

    }
    function approve(address spender,uint256 value)public override returns(bool){
        require(spender != address(0),"not a valid address");
        _allowed[msg.sender][spender] =  value;

        return true;
        emit Approval(msg.sender, spender, value);

    }
    function allowance(address owner,address spender)public view override returns(uint256){
        return _allowed[owner][spender];
    }

    function mint(address account,uint256 amount) public{
        require(account != address(0));
        _totalSupply += amount;
        _balances[account] += amount;

        emit Transfer(address(0),account,amount);
    }

    function burn(address account,uint256 amount) public{
        require(account != address(0));
        require(amount <= _balances[account],"haven't enough amount to burn");
        _totalSupply -= amount;
        _balances[account] -= amount;

        emit Transfer(address(0),account,amount);
    }

}
