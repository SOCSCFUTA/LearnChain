module learnchain::institution;

use std::string::String;
use sui::table::{Self, Table};
use sui::event as push;
use std::option::Option;
use learnchain::certification_batch::CertificationBatch;

public struct Institution has key {
    id: UID,
    name: String,
    public_key: String,
    offers_revokable_cert_batch: Option<bool>,
    years_issued: Table<u8, CertificationBatch>
}

public struct InstitutionCreatedEvent has drop, copy {
    id: ID,
    creator: address,
}
