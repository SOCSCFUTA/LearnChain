module learnchain::certification_batch;


public struct CertificationBatch has key, store {
    id: UID,
    institution_address: address,
    batch_year: u16,
    cert_hashes: vector<vector<u8>> //holds the hash of each candidate's graduating certificate. 
}

public struct CertificationBatchCreatedEvent  has drop,  copy{
    id: ID,
    institution_address:  address,
    creator: address,
}