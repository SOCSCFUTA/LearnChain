module learnchain::fees;

use sui::clock::{Self, Clock};
use sui::coin::{Self, Coin};
use cert_coin::cert_coin::CERT_COIN;

use cert_coin::vault::{Self, Vault};

const RECORD_MINTNG_FEE: u64  = 2000;
const ADD_TO_BATCH_FEE: u64 = 10;

public fun charge_fee_to_issue_certificate_batch(
    mut payment: Coin<CERT_COIN>,
    vault: &mut Vault,
    amount: u64,
    time: &Clock,
    ctx: &mut TxContext
){
    let coin_to_send = coin::split(&mut payment, amount, ctx);

    vault::deposit(
        vault,
        coin_to_send,   
        time,
        ctx
    );

    transfer::public_transfer(payment, ctx.sender());
}

public fun charge_fee_to_create_institution_object(
    mut payment: Coin<CERT_COIN>,
    vault: &mut Vault,
    time: &Clock,
    ctx: &mut TxContext
){
    let coin_to_send = coin::split(&mut payment, RECORD_MINTNG_FEE, ctx);

    vault::deposit(
        vault,
        coin_to_send,   
        time,
        ctx
    );

    transfer::public_transfer(payment, ctx.sender());
}


public fun charge_fee_to_add_hash_to_batch(
    mut payment: Coin<CERT_COIN>,
    vault: &mut Vault,
    time: &Clock,
    ctx: &mut TxContext
){
    let coin_to_send = coin::split(&mut payment, ADD_TO_BATCH_FEE, ctx);

    vault::deposit(
        vault,
        coin_to_send,   
        time,
        ctx
    );

    transfer::public_transfer(payment, ctx.sender());
}
