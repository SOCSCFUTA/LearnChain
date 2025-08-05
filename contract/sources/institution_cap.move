module learnchain::institution_cap;
use sui::event as push;
use std::string::String;
use std::ascii;
use sui::url::{Self, Url};

public struct InstitutionCap has key, store {
    id: UID,
    name: String,
    description: String,
    url: Url,
    active: bool,
    institution_profile_minted: bool
}

public struct InstiututionCapMinted has drop, copy {
    id: ID,
    creator: address
}

public(package) fun mint (
    ctx: &mut TxContext
): InstitutionCap{
    let cap = InstitutionCap{
        id: object::new(ctx),
        name: b"Institution Capacity".to_string(),
        description: b"This is your identity as a  verified institution that issues certificates to candidates.".to_string(),
        url: url::new_unsafe(ascii::string(b"https://link-to-image.com")),
        active: true,
        institution_profile_minted: false
    };

    push::emit(
        InstiututionCapMinted{
            id: object::id(&cap),
            creator: ctx.sender()
        }
    );
    cap
}

public(package) fun neutralize(
    cap: &mut  InstitutionCap
){
    cap.active = false;
}

public fun delete(
    cap:  InstitutionCap
){
    let InstitutionCap {
        id,
        name: _,
        description: _,
        url: _,
        active: _,
        institution_profile_minted: _
    } = cap;

    id.delete();
}

public(package) fun is_active(
    cap: &InstitutionCap
): bool{
    cap.active
}

public(package) fun  has_minted_institution_profile(
    cap: &InstitutionCap
): bool {
    cap.institution_profile_minted
}

public(package) fun set_minted_institution_profile(
    cap: &mut InstitutionCap
){
    cap.institution_profile_minted = true;
}



