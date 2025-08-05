module learnchain::admin;

use std::string::String;
use std::ascii;
use sui::url::{Self, Url};

public struct AdminCap has key, store {
    id: UID,
    name: String,
    desciption: String,
    url: Url
}

public struct ADMIN has drop {}

fun init(
    otw: ADMIN,
    ctx: &mut TxContext
){
    transfer::public_transfer(
        AdminCap{
            id: object::new(ctx),
            name:  b"Admin Capability for Learnchain platform.".to_string(),
            desciption: b"This is the first ever admin capability ever minted. It creates other admins for the platform, verify institutions, revoke institution priviledges...".to_string(),
            url: url::new_unsafe(ascii::string(b"https://link-to-image.com"))
        },
    ctx.sender()
    )
}

public(package) fun mint(
    ctx: &mut TxContext
): AdminCap  {
    AdminCap{
        id: object::new(ctx),
         name:  b"Admin Capability for Learnchain platform.".to_string(),
        desciption: b"This object is a signifier that your account can create other admins and also verify institutions before they interact with the blockchain .".to_string(),
        url: url::new_unsafe(ascii::string(b"https://link-to-image.com"))
    }
}