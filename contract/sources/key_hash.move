module learnchain::key_hash;

const ECertificateAlreadyRevoked: u64 =  10006;
const ECertificateAlreadyUnrevoked: u64 = 10008;
const ECertificateHashCannotBeDeleted: u64 = 10009;

public struct KeyHash has store, drop  {
    key: vector<u8>,
    hash: vector<u8>,
    revoked: bool,
}

public(package) fun create (
    key:  vector<u8>,
    hash: vector<u8>
): KeyHash {
    KeyHash {
        key,
        hash
        revoked: false,
    }
}

public(package) fun revoke (
    key_hash: &mut KeyHash
) {
    assert!(key_hash.revoked, ECertificateAlreadyRevoked);
    key_hash.revoked = true;
}

public(package) fun unrevote (
    key_hash: &mut KeyHash
){
    assert!(key_hash.revoked, ECertificateAlreadyUnrevoked);
    key_hash.revoked = false;
}


public(package) fun delete (
    key_hash: &KeyHash
){
    abort ECertificateHashCannotBeDeleted;
}