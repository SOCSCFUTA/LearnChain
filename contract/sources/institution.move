module learnchain::institution;


use sui::event as push;
use std::string::String;
use sui::table::{Self, Table};
use learnchain::certification_batch::CertificationBatch;
use  learnchain::certification_batch_metrics::CertificationBatchMetrics;
use std::ascii::{Self, String as AsciiString};
use sui::url::{Self, Url};


public struct InstitutionProfile has key, store {
    id: UID,
    name: String,
    url: Url,
    desciption: String,
    domain: Url,
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

public struct InstitutionProfileMinted has drop, copy {
    id: ID,
    creator: address
}

public struct INSTITUTION has drop {}


public(package) fun create(
    name: String,
    url: vector<u8>,
    desciption: String,
    domain: vector<u8>,
    offers_revokable_cert: bool,
    ctx: &mut TxContext
): InstitutionProfile {

   let cap = InstitutionProfile {
        id: object::new(ctx),
        name,
        url: url::new_unsafe(ascii::string(url)),
        desciption,
        domain: url::new_unsafe(ascii::string(domain)),
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
        InstitutionProfileMinted{
            id: object::id(&cap),
            creator:  ctx.sender()
        }
    });
    cap
}

public(package) fun add_batch_to_profile(
    batch: CertificationBatch,
    profile: &mut InstitutionProfile,
    key: u64,
){
    profile.batch.add(key, batch);
}
