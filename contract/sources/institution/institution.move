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
    cert_batch_issued: Table<u16, CertificationBatch>
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
    _: SignerCap,
    ctx: &mut TxContext
): Institution {

    let institution = Institution {
        id: object::new(ctx),
        name,
        public_key,
        offers_revokable_cert_batch,
        cert_batch_issued: table::new<u16, CertificationBatch>(ctx),
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
    _: SignerCap,
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
        cert_batch_issued
    } = institution;

    certification_batch::delete(cert_batch_issued);
    id.delete();
}
