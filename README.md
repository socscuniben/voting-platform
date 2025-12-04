# Decentralized Voting System on Sui

Welcome to the Decentralized Voting System project! This project is designed to teach junior developers the fundamentals of Move programming on the Sui blockchain.

## Project Overview

This is a decentralized application (dApp) that allows:
- **Admins** to create elections, register candidates, and manage the voting process.
- **Voters** to register and cast their votes securely.
- **Transparency**: All results are verifiable on-chain.

## Architecture

The system is built around several core Move objects:

### 1. Election (`Election`)
The central object that stores the state of an election.
- **Fields**: `id`, `name`, `description`, `start_time`, `end_time`, `is_active`, `is_ended`.
- **Data Structures**:
    - `candidate_addresses`: List of candidate addresses.
    - `candidate_info`: Map of address to `CandidateInfo` (name, description, pfp).
    - `vote_counts`: Map of address to vote count.
    - `voters`: Map of address to boolean (has voted?).
    - `winner`: Stores the winner's address after the election ends.

### 2. Candidate Pass (`CandidatePass`)
An object transferred to a candidate upon registration.
- **Fields**: `id`, `election_id`, `candidate_address`, `name`, `description`, `pfp`.

### 3. Vote Pass (`VotePass`)
An object transferred to a voter upon registration.
- **Fields**: `id`, `election_id`, `voter_address`, `has_voted`, `voted_for`.
- **Purpose**: Acts as a "ticket" to cast a vote.

### 4. Election Admin Capability (`ElectionAdminCap`)
A capability object that grants admin privileges.
- **Owner**: The creator of the election.
- **Powers**: Register candidates/voters, start/end election, update settings.

### 5. Election Result (`ElectionResult`)
An immutable object created when an election ends.
- **Fields**: Winner details, total votes, and a full ranking of results.

## Flow

1.  **Setup**: User creates an election -> receives `ElectionAdminCap`.
2.  **Registration**:
    - Admin registers candidates -> Candidates receive `CandidatePass`.
    - Admin registers voters -> Voters receive `VotePass`.
3.  **Voting**:
    - Admin starts election (`is_active = true`).
    - Voters cast votes using their `VotePass`.
    - Votes are recorded in `Election` object.
4.  **Conclusion**:
    - Admin ends election.
    - Winner is calculated.
    - `ElectionResult` is published.

## Contribution Guide

This project is divided into small, manageable issues. Each issue corresponds to a specific feature or component of the system.

### How to Contribute
1.  Read the `issue#X.md` file for the task you want to work on.
2.  Implement the required structs and functions in `sources/vote.move`.
3.  Ensure your code compiles and follows Move conventions.

### Available Issues
- [Issue #1: Core Structs & Setup](./issue#1.md)
- [Issue #2: Election Administration](./issue#2.md)
- [Issue #3: Candidate Management](./issue#3.md)
- [Issue #4: Voter Registration](./issue#4.md)
- [Issue #5: Voting Logic](./issue#5.md)
- [Issue #6: Election Conclusion](./issue#6.md)
- [Issue #7: Events & Helpers](./issue#7.md)
