module learnchain::signer;

use sui::event as push;

public struct SignerCap has key, store {
    id: UID,
}

public struct SignerCapMinted has drop, copy {
    id: ID,
    creator: address
}

public struct SignerCapTransfered has drop, copy {
    id: ID,
    previous_owner: address,
    new_owner: address
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

public(package) fun transfer(
    cap: SignerCap,
    reciever: address,
    ctx: &mut TxContext
){
    push::emit({
        SignerCapTransfered{
            id:  object::id(&cap),
            previous_owner: ctx.sender(),
            new_owner: reciever
        }
    });

    transfer::public_transfer(cap, reciever);
}