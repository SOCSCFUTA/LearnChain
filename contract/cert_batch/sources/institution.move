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
    batch: Table<vector<u8>, CertificationBatch>,
    metrics: Table<vector<u8>, CertificationBatchMetrics>,
    record: Record,
    owner: address
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
        batch: table::new<vector<u8>, CertificationBatch>(ctx),
        metrics: table::new<vector<u8>, CertificationBatchMetrics>(ctx),
        record: Record {
            total_cert_count: 0,
            last_batch_size: 0,
            revoked_cert_count: 0,
            initial_batch_release: option::none(),
            latest_batch_release: option::none(),
            offers_revokable_cert
        },
        owner: ctx.sender()
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
    profile: &mut InstitutionProfile,
    metrics: CertificationBatchMetrics,
    batch: CertificationBatch,
    key: vector<u8>,
){
    profile.batch.add(key, batch);
    profile.metrics.add(key, metrics);
}

public fun get_owner(
    institution:  &InstitutionProfile
): address {
    institution.owner
}
