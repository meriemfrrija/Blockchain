pragma solidity ^0.5.0;

contract Election {
    // Model a Candidate
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
        }

    // Store accounts that have voted
    mapping(address => bool) public voters;

    // Read/write Candidates
    mapping(uint => Candidate) public candidates;

    // Store Candidates Count
    uint public candidatesCount;

    function addCandidate (string memory _name) public {
        require(msg.sender == 0xe736C357511dd11B175f90968913CF22Ada647eC || msg.sender == 0x8E0DDc639501dA9ed84F9f378e548083C3fde18A);
        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }
    
    
    event votedEvent (
    uint indexed _candidateId
    );

    function vote (uint _candidateId) public {
        // require that they haven't voted before
        require(!voters[msg.sender]);
        // require a valid candidate
        require(_candidateId > 0 && _candidateId <= candidatesCount);
        // record that voter has voted
        voters[msg.sender] = true;
        // update candidate vote Count
        candidates[_candidateId].voteCount ++;

        // trigger voted event
        emit votedEvent(_candidateId);
        }


    constructor() public {
        addCandidate("Candidate 1");
        addCandidate("Candidate 2");
    }
}
