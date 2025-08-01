module learnchain::certification_batch_metrics;

public struct CertificationBatchMetrics has store {
    batch_id: ID,
    cert_count: u64,
    issued_on: vector<u8>,
    signer_address: address,
    revoked_count: u64
}

public(package) fun create(
    batch_id: ID,
    cert_count: u64,
    issued_on: vector<u8>,
    signer_address: address,
    revoked_count: u64
): CertificationBatchMetrics {

    CertificationBatchMetrics {
        batch_id,
        cert_count,
        issued_on,
        signer_address,
        revoked_count,
    }
}