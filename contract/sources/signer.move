module learnchain::signer;

use sui::event as push;

public struct SignerCap has key, store {
    id: UID,
}

public struct SignerCapMinted has drop, copy {
    id: ID,
    creator: address
}

public struct SIGNER has drop {}

fun init(
    otw: SIGNER,
    ctx: &mut TxContext
) {

    let signerCap = SignerCap{
        id: object::new(ctx)
    };

    push::emit({
        SignerCapMinted{
            id: object::id(&signerCap),
            creator:  ctx.sender()
        }
    });

    transfer::public_transfer(signerCap, ctx.sender());
}

public(package) fun mint(
    _: SignerCap,
    ctx: &mut TxContext
): SignerCap {

   let cap = SignerCap {
        id: object::new(ctx),
    };

    push::emit({
        SignerCapMinted{
            id: object::id(&cap),
            creator:  ctx.sender()
        }
    });

    cap

}