// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract VotingSystem {

    //Define Struct for Candidate and voter
    struct Candidate {
        string name;
        uint256 voteCount;
    }

    struct Voter {
        bool hasVoted;
        uint256 votedForCandidate;
    }
    
    mapping(uint256 => Candidate) public candidates;
    uint256 public candidateCount;


    mapping(address => Voter) public voters;

    constructor(string[] memory candidateNames) {
        for (uint256 i = 0; i < candidateNames.length; i++) {
            addCandidate(candidateNames[i]);
        }
    }

    function addCandidate(string memory name) private {
        require(bytes(name).length > 0, "Invalid candidate name");
        candidateCount++;
        candidates[candidateCount] = Candidate(name, 0);
    }

    function vote(uint256 candidateId) public {
        require(candidateId > 0 && candidateId <= candidateCount, "Invalid candidate");
        require(!voters[msg.sender].hasVoted, "You have already voted"); //ensure a users votes only once

        voters[msg.sender].hasVoted = true;
        voters[msg.sender].votedForCandidate = candidateId;

        candidates[candidateId].voteCount++;
    }

    function getCandidateVoteCount(uint256 candidateId) public view returns (uint256) {
        require(candidateId > 0 && candidateId <= candidateCount, "Invalid candidate");
        return candidates[candidateId].voteCount;
    }
}