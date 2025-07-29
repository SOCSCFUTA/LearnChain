module learnchain::certification_batch;

use sui::table::{Self, Table};
use std::string::String;


public struct CertificationBatch has key, store {
    id: UID,
    issuer: address,
    batch_year: u16,
    count: u16,
    cert_hashes: vector<vector<u8>> //holds the hash of each candidate's graduating certificate. 
}

public struct CertificationBatchCreatedEvent  has drop,  copy{
    id: ID,
    issuer: address,
    creator: address,
}

public(package) fun create(
    issuer: address,
    batch_year: u16,
    cert_hashes: vector<String>,
    count: u16,
    ctx: &mut TxContext
): CertificationBatch{

    CertificationBatch{
        id: object::new(ctx),
        issuer,
        batch_year,
        count,
        cert_hashes
    }
}

public(package) fun  remove_hash(
   hash_batch: &mut CertificationBatch,
   hash: String,
): &CertificationBatch{

    hash_batch.cert_hashes.pop_back(hash);
    hash_batch
}

public(package) fun add_hash(
    hash_batch: &mut CertificationBatch,
    hash: String,
): &CertificationBatch{

    hash_batch.cert_hashes.push_back(hash);
    hash_batch
}

public(package) fun delete(
    cert: CertificationBatch
) {
    let CertificationBatch {
        id,
        institution_address: _,
        batch_year: _,
        cert_hashes: _
    } = cert;

    id.delete();
}



