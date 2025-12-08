module vote::vote {
  
    use sui::vec_map::VecMap;
    use std::string::String;
    use sui::event;
    use std::option::Option;
    use sui::clock;






    // Election object 
    public struct Election has key {
        id: UID,
        name: String,
        description: String,
        start_time: u64,
        end_time: u64,
        is_active: bool,
        is_ended: bool,
        candidate_addresses: vector<address>,  // Fixed typo
        candidate_info: VecMap<address, CandidateInfo>,
        vote_counts: VecMap<address, u64>,  // Changed from bool to u64
        voters: VecMap<address, bool>,
        total_votes: u64, 
        winner: Option<address>
    }

    // Candidate object (fixed name capitalization)
    public struct CandidateInfo has copy, store, drop {
        name: String,
        description: String,
        pfp: String,
    }

    // Vote pass object 
    public struct VotePass has key, store {
        id: UID,
        name: String,
        voter_address: address,
        election_id: ID,  // Changed from u64 to ID
        has_voted: bool,
        voted_for: address,  // Changed from u64 to address for candidate
    }

    // Candidate pass object 
    public struct CandidatePass has key, store {
        id: UID,
        name: String,
        candidate_address: address,
        election_id: ID,  // Changed from u64 to ID
        description: String,
        used: bool,
        pfp: String,
    }

    // Election admin object
    public struct ElectionAdminCap has key, store {
        id: UID,
        election_id: ID,
    }

    // Vote object
    public struct Vote has key, store {
        id: UID,
        candidate_address: address,  // Changed from u64 to address
        election_id: ID,  // Changed from u64 to ID
        voter_address: address,
        timestamp: u64,
    }

    // Election result object
    public struct ElectionResult has key, store {
        id: UID,
        election_id: ID,  // Changed from u64 to ID
        election_name: String,
        election_description: String,
        winner_address: address,
        winner_name: String,  // Changed from u64 to String
        winner_description: String,
        winner_votes: u64,
        winner_pfp: String,
        total_votes: u64,
        end_time: u64,
        all_results: VecMap<address, u64>
    }

    // Election created event (fixed typo)
    public struct ElectionCreatedEvent has copy, drop {
        election_id: ID,  // Changed from u64 to ID
        name: String,
        candidate_addresses: vector<address>,  // Fixed typo
        start_time: u64,
        end_time: u64,
        timestamp: u64,
    }

    // Candidate registered event
    public struct CandidateRegisteredEvent has copy, drop {
        election_id: ID,
        candidate_address: address,
        name: String,
        pfp: String,
        timestamp: u64,
    }

    // Vote casted event
    public struct VoteCastedEvent has copy, drop {
        election_id: ID,
        candidate_address: address,
        voter_address: address,
        timestamp: u64,
    }

    // Voter registered event 
    public struct VoterRegisteredEvent has copy, drop {
        election_id: ID,
        voter_address: address,
        timestamp: u64,
    }

    // Election ended event
    public struct ElectionEndedEvent has copy, drop {
        election_id: ID,
        winner_address: address,
        winner_name: String,
        winner_description: String,
        winner_votes: u64,
        total_votes: u64,
        end_time: u64,
        timestamp: u64,
    }

    // Election started event
    public struct ElectionStartedEvent has copy, drop {
        election_id: ID,
        name: String,
        description: String,
        start_time: u64,
        end_time: u64,
        timestamp: u64,
    }

    // Your functions go here...

// create_election() function
public entry fun create_election(
    name: String,
    description: String,
    start_time: u64,
    end_time: u64,
    candidate_addresses: vector<address>,
    candidate_names: vector<String>,
    candidate_descriptions: vector<String>,
     ctx: &mut TxContext
)
{
    let election = Election {
        id: election_uid,
        name,
        description,
        start_time,
        end_time,
        is_active,
        is_ended: false,
        candidate_addresses,
        candidate_info,
        vote_counts,
        voters: vec_map::empty<address, bool>(),
        total_votes: 0,
        winner: option::none(),
    };
}
    // Emit event
    event::emit(ElectionCreatedEvent {
        election_id,
        name: election.name,
        candidate_addresses: election.candidate_addresses,
        start_time,
        end_time,
        timestamp: current_time,
    });
    
    // Transfer the election object to the creator or share it publicly
    transfer::share_object(election);
}


// register_candidate() function
public entry fun register_candidate(
    election: &mut Election,
    candidate_address: address,
    name: String,
    description: String,
    pfp: String,
    ctx: &mut TxContext
) {
    let candidate_info = CandidateInfo {
        name,
        description,
        pfp,
    };
} {
    event::emit(CandidateRegisteredEvent {
        election_id,
        candidate_address,
        name,
        pfp,
        timestamp: clock::now_seconds(clock),
    });
    // Implementation here
}


// register_voter() function
public entry fun register_voter(
    election: &mut Election,
    voter_address: address,
    ctx: &mut TxContext
) {
    let voter = Voter {
        address: voter_address,
        has_voted: false,
        voted_for: option::none(),
    };
    event::emit(VoterRegisteredEvent {
        election_id: election.id,
        voter_address,
        timestamp: clock::now_seconds(clock),
    });
    // Implementation here
}

// cast_vote() function
public entry fun cast_vote(
    election: &mut Election,
    candidate_address: address,
    voter_address: address,
    ctx: &mut TxContext
) {
    // Implementation here
    event::emit(VoteCastedEvent {
        election_id: election.id,
        candidate_address,
        voter_address,
        timestamp: clock::now_seconds(clock),
    });
}



//end_election() function

public entry fun end_election(
    election: &mut Election,
    ctx: &mut TxContext
) {
    // Implementation here
    event::emit(ElectionEndedEvent {
        election_id: election.id,
        winner_address,
        winner_name,
        winner_description,
        winner_votes,
        total_votes: election.total_votes,
        end_time: election.end_time,
        timestamp: clock::now_seconds(clock),
    });
}

//start_election() function
public entry fun start_election(
    election: &mut Election,
    ctx: &mut TxContext
) {
    // Implementation here
    event::emit(ElectionStartedEvent {
        election_id: election.id,
        name: election.name,
        description: election.description,
        start_time: election.start_time,
        end_time: election.end_time,
        timestamp: clock::now_seconds(clock),
    });
}

//Helper functions


//calculate_results() function

//get_election() function

//get_candidate() function

//get_voter() function

//get_all_voters_for_a_candidate() function

//get_all_voters_for_an_election() function

//get_election_results() functionn

//delete_candidate() / remove_candidate()



//deregister_voter()


//withdraw_vote() (optional)  
        


//extend_election_time()


//pause_election() (optional)
















}