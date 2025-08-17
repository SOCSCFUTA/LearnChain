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
    batch: Table<vector<u8>, CertificationBatch>,
    metrics: Table<vector<u8>, CertificationBatchMetrics>,
    record: Record,
    owner: address
}

public struct Record has store, copy {
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
    offers_revokable_cert: bool,
    ctx: &mut TxContext
): InstitutionProfile {

   let cap = InstitutionProfile {
        id: object::new(ctx),
        name,
        url: url::new_unsafe(ascii::string(url)),
        desciption,
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

public fun get_name(
    institution: &InstitutionProfile
): String {
    institution.name
}

public fun get_url(
    institution: &InstitutionProfile
): Url {
    institution.url
}

public fun get_institution_reccord(
    institution: &InstitutionProfile
): Record {
    institution.record
}

public fun get_entire_certificate_batch(
    institution: &InstitutionProfile
): &Table<vector<u8>, CertificationBatch>{
    &institution.batch
}

public fun get_entire_certificate_metrics(
    institution: &InstitutionProfile
): &Table<vector<u8>, CertificationBatchMetrics>{
    &institution.metrics
}

public fun  get_certificate_batch_by_key(
    institution: &InstitutionProfile,
    key: vector<u8>
): &CertificationBatch{
    &institution.batch[key]
}

public fun  get_certificate_batch_metrics_by_key(
    institution: &InstitutionProfile,
    key: vector<u8>
): &CertificationBatchMetrics{
    &institution.metrics[key]
}