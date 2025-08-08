module cert_coin::capacity;
use sui::coin::{Self, Coin};

const ENotACreator: u64 = 10001;

public struct VaultCap has key, store{
    id: UID,
    creator: bool, //checks if this user can create VaultCap
}

public struct CAPACITY has drop {}

fun init(
    withdraw: CAPACITY,
    ctx: &mut TxContext
){
    let cap = VaultCap{
        id: object::new(ctx),
        creator: true,
    };

    transfer::public_transfer(cap, ctx.sender());
}

entry fun delete_capacity(
    cap: VaultCap
){
    let VaultCap{ id, creator: _} = cap;
    id.delete();
}

entry fun transfer_capacity(
    cap: VaultCap,
    recepient: address
){
    assert!(cap.creator, ENotACreator);
    transfer::public_transfer(cap, recepient);
}

entry fun mint_and_transfer_capacity_creator(
    cap: &VaultCap,
    recepient: address,
    ctx: &mut TxContext
){
    assert!(cap.creator, ENotACreator);
    let cap = VaultCap{
        id: object::new(ctx),
        creator: true,
    };

    transfer::public_transfer(cap, recepient);

}

entry fun mint_and_transfer_capacity(
    cap: &VaultCap,
    recepient: address,
    ctx: &mut TxContext
){
    assert!(cap.creator, ENotACreator);
    let cap = VaultCap{
        id: object::new(ctx),
        creator: false,
    };

    transfer::public_transfer(cap, recepient);

}