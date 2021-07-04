/**
Once the contract is created the constructor sets the owner to msg.sender the person who deployed it
The onlyOwner modifier restricts access for certain fuctions to only the owner
It allows you to transfer ownership to a new owner 
It also allows you to  give up ownership of the contract

 */
contract Ownable{
    address private _owner;

    event OwnershipTransffered(
        address indexed previousOwner,
        address indexed newOwner
    );

    /**
    @dev This constructor sets the original owner/the person that deployed the contract. It is an 
    optional special function that has the same name as the contract. It only gets executed once
    when the contract is first created
     */ 

    constructor() internal {
        _owner = msg.sender;
        emit OwnershipTransffered(address(0), _owner);
    }

    /**
    @return Return the address of an owner
    */
    function owner() public view returns(address){
        return _owner;
    }

    /**
    @dev Throws if called by account other than the owner

    Modifiers are half functions thatg are used to modify other functions, usually to check requirements prior to executing the 
    program. Here we are we are limiting access so that only the owner of the contract can run this function.
     */

    modifier onlyOwner(){
        require(isOwner());
        _;
    }

    /**
    @return true if msg.sender is the owner of the contract
     */
    function isOwner() public view returns(bool){
        return msg.sender == _owner;
    }

    /** 
    Allows you to relenquish control of the contract. Renouncing the ownership will leave the contract without
    an owner. It will not be possible to call functions with onlyOwner anymore.
    */
    function renounceOwnership() public onlyOwner{
        emit OwnershipTransffered(_owner, address(0));
        _owner = address(0);
    }

    /**
    @dev Allows the current owner to transfer control of the contract to a new owner.
    @param newOwner The address to transfer ownership to.
     */

    function transferOwnership(address newOwner) public onlyOwner{
        _transferOwnership(newOwner);
    }

    /**
    @dev Transfers control of the contract to a new owner
    @param newOwner The address to transfer the ownership to
     */

    function _transferOwnership(address newOwner) internal{
        require(newOwner != address(0));
        emit OwnershipTransffered(_owner, newOwner);
        _owner = newOwner;
    }

}