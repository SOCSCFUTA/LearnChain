module learnchain::institution_cap;
use sui::event as push;

public struct InstitutionCap has key {
    id: UID,
    active: bool,
    issuer_node_minted: bool
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
        active: true,
        issuer_node_minted: false
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
        active: _,
        issuer_node_minted: _
    } = cap;

    id.delete();
}

public(package) fun is_active(
    cap: &InstitutionCap
): bool{
    cap.active
}

public(package) fun  has_minted_issuer_node(
    cap: &InstitutionCap
): bool {
    cap.issuer_node_minted
}

