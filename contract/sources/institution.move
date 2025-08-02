module learnchain::institution;


use sui::event as push;
use std::string::String;
use sui::url::Url;
use sui::table::{Self, Table};
use learnchain::certification_batch::CertificationBatch;
use  learnchain::certification_batch_metrics::CertificationBatchMetrics;

public struct InstitutionCap has key, store {
    id: UID,
    name: String,
    url: Url,
    desciption: String,
    batch: Table<u64, CertificationBatch>,
    metrics: Table<u64, CertificationBatchMetrics>,
    record: Record,
}

public struct Record has store {
    total_cert_count: u8,
    last_batch_size: u8,
    revoked_cert_count: u8,
    initial_batch_release: Option<vector<u8>>,
    latest_batch_release: Option<vector<u8>>,
    offers_revokable_cert: bool
}

public struct InstitutionCapMinted has drop, copy {
    id: ID,
    creator: address
}

public struct INSTITUTION has drop {}


public(package) fun mint(
    name: String,
    url: Url,
    desciption: String,
    offers_revokable_cert: bool,
    ctx: &mut TxContext
): InstitutionCap {

   let cap = InstitutionCap {
        id: object::new(ctx),
        name,
        url,
        desciption,
        batch: table::new<u64, CertificationBatch>(ctx),
        metrics: table::new<u64, CertificationBatchMetrics>(ctx),
        record: Record {
            total_cert_count: 0,
            last_batch_size: 0,
            revoked_cert_count: 0,
            initial_batch_release: option::none(),
            latest_batch_release: option::none(),
            offers_revokable_cert
        }
    };

    push::emit({
        InstitutionCapMinted{
            id: object::id(&cap),
            creator:  ctx.sender()
        }
    });
    cap
}
