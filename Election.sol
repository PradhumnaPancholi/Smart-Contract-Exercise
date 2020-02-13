pragma solidity ^0.5.11;

contract Election{
    address public owner;
    string public name;
    uint public totalVotes;
    //event to triiger when a vote is casted//
    event Vote(string candidateName, uint voteCount);
    //structure for candidate//
    struct Candidate{
        string name;
        uint voteCount;
    }
    //structure for voter//
    struct Voter{
        bool authorized;
        bool voted;
        uint vote; //for candidate id//
    }
    //just a simple constructor to initialize the contract//
    constructor(string memory _name) public{
        owner = msg.sender;
        name = _name;
    }
    //modifier to verify the owner//
    modifier ownerOnly() {
        require(msg.sender == owner, 'Only owner is authorized for performing this task');
        _;
    }
    //array of type candidate to keep a list of candidates//
    Candidate[] public candidateList;
    // mapping that uses 'address' as index and returns a voter//
    mapping(address => Voter) public voterList;
    //methods to create a new candidate//
    function addCandidate(string memory _name) public ownerOnly{
        candidateList.push(Candidate(_name, 0));
    }
    //method to get candidate count//
    function getCandidateCount() public view returns (uint){
        return candidateList.length;
    }
    // method to create & authorize a voter//
    function authorizeVoter(address _voter) public ownerOnly{
        //check if voter already voted//
        require(!voterList[_voter].voted, 'User already voted');
        //authorize voter//
        voterList[_voter].authorized = true;
    }
    // method to vote for an candidate//
    function castVote(uint _candidate) public {
        // checkif user is allowed to vote//
        require(voterList[msg.sender].authorized, 'User is not authorized to vote');
        require(!voterList[msg.sender].voted, 'User has alreay voted');
        require(_candidate < candidateList.length, 'Invalid Candidate');
        //setting data on voter object//
        voterList[msg.sender]. vote = _candidate;
        voterList[msg.sender].voted = true;
        //updating vote counts//
        candidateList[_candidate].voteCount += 1;
        totalVotes += 1;
        //emit vote //
        emit Vote(candidateList[_candidate].name, totalVotes);
    }
}