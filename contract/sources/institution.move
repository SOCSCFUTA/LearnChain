module learnchain::institution;

use std::string::String;
use sui::table::{Self, Table};
use sui::event as push;
use std::option::Option;
use learnchain::certification_batch::{Self, CertificationBatch};
use learnchain::signer::SignerCap;

//error code
const ENotAuthorized: u64 = 10007;

public struct Institution has key {
    id: UID,
    name: String,
    public_key: vector<u8>,
    offers_revokable_cert_batch: Option<bool>,
    cert_batch_issued: Table<u16, CertificationBatch>,
    releases: Releases
}

public struct Releases has store, drop, copy{
     count: u16,
     initial: u64,
     latest: u64
}

public struct InstitutionCreatedEvent has drop, copy {
    id: ID,
    creator: address,
}

public struct InstitutionDeletedEvent has drop, copy {
    id: ID,
    reason: String,
    deleted_by: address,
}

public(package) fun create(
    name: String,
    public_key: vector<u8>,
    offers_revokable_cert_batch: Option<bool>,
    ctx: &mut TxContext
): Institution {

    let institution = Institution {
        id: object::new(ctx),
        name,
        public_key,
        offers_revokable_cert_batch,
        cert_batch_issued: table::new<u16, CertificationBatch>(ctx),
        releases: Releases {
            count: 0,
            initial: 0000,
            latest: 0000
        }
    };

    push::emit(
        InstitutionCreatedEvent{
            id: object::id(&institution),
            creator:  ctx.sender()
        }
    );

    institution
}

public(package) fun delete (
    institution: Institution,
    public_key: vector<u8>,
    reason: String,
    ctx:  &mut TxContext
) {

    assert!(institution.public_key == public_key, ENotAuthorized );

    push::emit(
        InstitutionDeletedEvent{
            id: object::id(&institution),
            reason,
            deleted_by: ctx.sender()
        }
    );

    let Institution {
        id,
        name: _,
        public_key: _,
        offers_revokable_cert_batch: _,
        mut cert_batch_issued,
        releases
    } = institution;

    let mut index = releases.count -1;
    while (cert_batch_issued.length() > 0) {
        let batch = cert_batch_issued.remove(index);
        certification_batch::delete_batch(batch);
        index = index - 1;
    };

    cert_batch_issued.destroy_empty();
    id.delete()
}
