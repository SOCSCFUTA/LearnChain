module cert_coin::vault;
use cert_coin::cert_coin::CERT_COIN;
use cert_coin::capacity::VaultCap;
use sui::clock::{Self, Clock};
use sui::coin::{Self, Coin};
use sui::balance::{Self, Balance};
use sui::event as push;

public struct Vault has key, store {
    id: UID,
    balance: Balance<CERT_COIN>
}

public struct CoinDepositedToVault has copy, drop {
    id: ID,
    initiator: address,
    timestamp: u64
}

public struct CoinWithdrawnFromVault has copy, drop {
    id: ID,
    amount: u64,
    initiator: address,
    timestamp:  u64
}

public struct VAULT has drop {}

fun init(
    witness: VAULT,
    ctx: &mut TxContext
){
    transfer::share_object(
        Vault{
            id: object::new(ctx),
            balance: balance::zero<CERT_COIN>()
        },
    );
}

public entry fun deposit (
    vault: &mut Vault,
    coins: Coin<CERT_COIN>,
    time: &Clock,
    ctx: &mut TxContext
){

    let amount = coin::into_balance(coins);
    push::emit(CoinDepositedToVault{
        id: object::id(vault),
        initiator: ctx.sender(),
        timestamp: time.timestamp_ms()
    });
    balance::join(&mut vault.balance, amount);
}

public entry fun withdraw(
    _cap: &VaultCap,
    vault: &mut Vault,
    amount: u64,
    time: &Clock,
    ctx: &mut TxContext
){
    let coin_from_balance = coin::from_balance(balance::split(
        &mut vault.balance,
        amount
    ),
    ctx
    );
        push::emit(CoinWithdrawnFromVault{
        id: object::id(vault),
        amount,
        initiator: ctx.sender(),
        timestamp: time.timestamp_ms()
    });

    transfer::public_transfer(coin_from_balance, ctx.sender());
}