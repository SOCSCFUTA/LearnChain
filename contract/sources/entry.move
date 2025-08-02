module learnchain::entry;
use learnchain::admin::{Self, AdminCap};
use learnchain::institution::{Self, InstitutionProfile};
use learnchain::institution_cap::{Self, InstitutionCap};

use std::string::String;
use std::ascii::{Self, String as AsciiString};
use sui::url::{Self, Url};

const EInstitutionProfileMintedAlready: u64 = 10012;
const EKeyandHashLengthMismatch: u64 = 10013;
//for admins

///admins can mint AdminCap for others to have admin priviledges
public entry fun mint_admin_cap(
    _: &AdminCap,
    receiever: address,
    ctx: &mut TxContext
){
    transfer::public_transfer(admin::mint(ctx), receiever);
}

///After verification of the Insiutuion, admin can mint Instiution priviledge and transfer to the institution address
///This allows the institution to sign transactions to the blockchain.

public entry fun mint_institution_cap(
    _: &AdminCap,
    institution_address: address,
    ctx: &mut TxContext
){
    transfer::public_transfer(institution_cap::mint(ctx) ,institution_address);
}

public entry fun revoke_institution_cap(
    _: &AdminCap,
    cap: &mut InstitutionCap
){
    institution_cap::neutralize(cap);
}


///for institutions
/// The institution  will  create once, a shared on-chain object which will serve as a record to store the information about the institution and certificates that was issued.

public entry fun create_institution_record(
    cap: &mut InstitutionCap,
    name: String,
    url: vector<u8>,
    desciption: String,
    domain: vector<u8>,
    offers_revokable_cert: bool,
    ctx: &mut TxContext
){

    assert!(cap.has_minted_institution_profile(), EInstitutionProfileMintedAlready);
    let institutionRecord = institution::create(
        name,
        url,
        desciption,
        domain,
        offers_revokable_cert,
        ctx
    );

    transfer::public_transfer(institutionRecord, ctx.sender());
    cap.set_minted_institution_profile();
}

///The institution can also send an  array of certifificate for each students in this form
/// key: This unique key is what the organization gives to  the candidate  when taking  the examination
/// hash: This is a hashed string of the encrypted metadata of the candidate

//the keys and hashes will be passed in as a different array to the smart contract.
public entry fun issue_certificate_batch(
    _: &InstitutionCap,
    keys: vector<vector<u8>>,
    hashes: vector<vector<u8>>,
    batch_year: u64,
    profile: &mut InstitutionProfile
){

}