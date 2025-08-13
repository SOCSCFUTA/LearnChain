module cert_coin::cert_coin;
use sui::coin::{Self,  TreasuryCap, Coin};
use sui::url::{Self, Url};
use std::ascii;

public struct CERT_COIN has drop {}

fun init( witness: CERT_COIN, ctx: &mut TxContext){
    let ( treasury, metadata ) = coin::create_currency(
        witness,
        3,
        b"Cert",
        b"CCN",
        b"This token coin is used by institutions on the Learnchain platform when they issue certificate batch for a period of time.",
        option::some(url::new_unsafe(ascii::string(b"https://drive.usercontent.google.com/download?id=1VoLjzCCp18ZfZlcubwq9UkFiH3CKjG52&export=view&authuser=0"))),
        ctx
    );

    transfer::public_freeze_object(metadata);
    transfer::public_transfer(treasury, ctx.sender());
}

entry fun mint_and_transfer(
    treasury:  &mut TreasuryCap<CERT_COIN>,
    amount: u64,
    recepient: address,
    ctx: &mut TxContext
){
    let  coin = coin::mint(treasury, amount, ctx);
    transfer::public_transfer(coin, recepient);
}

entry fun split_and_transfer(
    coin: &mut Coin<CERT_COIN>,
    amount: u64,
    recepient: address,
    ctx: &mut TxContext
){
    let balance = coin::split( coin, amount, ctx);
    transfer::public_transfer(balance, recepient);
}

entry fun burn(
    coin_object: Coin<CERT_COIN>,
    treasury: &mut TreasuryCap<CERT_COIN>
){
    coin::burn(treasury, coin_object);
}





