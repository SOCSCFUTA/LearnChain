module learnchain::certification_batch;

use sui::table::{Self, Table};


public struct CertificationBatch has key, store {
    id: UID,
    institution_address: address,
    batch_year: u16,
    cert_hashes: vector<vector<u8>> //holds the hash of each candidate's graduating certificate. 
}

public struct CertificationBatchCreatedEvent  has drop,  copy{
    id: ID,
    institution_address: address,
    creator: address,
}

public(package) fun delete(
    cert_table: Table<u16, CertificationBatch>
) {
   
}



