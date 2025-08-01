module learnchain::certification_batch;

use sui::table::{Self, Table};
use std::string::String;
use learnchain::key_hash::{Self, KeyHash};

const EBatchNoLongerAcceptsHash: u64 = 10010;
const EHashCannotBeRemovedFromBatch: u64 = 10011;


public struct CertificationBatch has key, store {
    id: UID,
    issuer: address,
    batch_year: u16,
    count: u16,
    hashes: vector<KeyHash> //holds the hash of each candidate's graduating certificate. 
}

public struct CertificationBatchCreatedEvent  has drop,  copy{
    id: ID,
    issuer: address,
    creator: address,
}

public(package) fun create(
    issuer: address,
    batch_year: u16,
    hash: vector<u8>,
    key: vector<u8>,
    count: u16,
    ctx: &mut TxContext
): CertificationBatch{

    CertificationBatch{
        id: object::new(ctx),
        issuer,
        batch_year,
        count,
        hashes: vector[key_hash::create(key, hash)],
    }
}


public(package) fun add_hash_to_batch(
    batch: &mut CertificationBatch,
    hash: vector<u8>,
    key: vector<u8>
){
    
    batch.hashes.push_back(key_hash::create(key, hash))
}


public(package) fun delete_hash_from_batch (
    batch: &mut CertificationBatch,
    index: u16
){
    abort EHashCannotBeRemovedFromBatch;
}

public(package) fun delete_batch(
    cert: CertificationBatch
) {
    let CertificationBatch {
        id,
        issuer: _,
        batch_year: _,
        count: _,
        hashes: _,
    } = cert;

    id.delete();
}



