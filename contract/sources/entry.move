module learnchain::entry;
use learnchain::admin::{Self, AdminCap};
use learnchain::institution::{Self, mint};
use learnchain::institution_cap;

use std::string::String;
use std::ascii::{Self, String as AsciiString};
use sui::url::{Self, Url};

//for admins

///admins can mint AdminCap for others
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
    transfer::transfer(institution_cap::mint(ctx) ,institution_address);
}

public entry fun revoke_institution_cap(
    _: &AdminCap,

){

}