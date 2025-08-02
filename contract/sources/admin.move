module learnchain::admin;

public struct AdminCap has key, store {
    id: UID
}

public struct ADMIN has drop {}

fun init(
    otw: ADMIN,
    ctx: &mut TxContext
){
    transfer::public_transfer(
        AdminCap{
            id: object::new(ctx)
        },
    ctx.sender()
    )
}

public(package) fun mint(
    ctx: &mut TxContext
): AdminCap  {
    AdminCap{
        id: object::new(ctx)
    }
}