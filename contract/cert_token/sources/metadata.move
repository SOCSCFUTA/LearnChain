module cert_coin::metadata;
use sui::coin::{Self,  TreasuryCap, Coin};
use cert_coin::cert_coin::CERT_COIN;

entry fun get_total_supply(
    treasury: &TreasuryCap<CERT_COIN>
): u64{
    coin::total_supply<CERT_COIN>(treasury)
}

entry fun get_value(
    coin_object: &Coin<CERT_COIN>
):u64 {
    coin_object.value()
}
