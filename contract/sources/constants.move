#[allow(unused_const)]
module learnchain::errors;

const ECertificateHashBatchMisMatch: u64 = 10000;
const EIntitutionNotFound: u64 = 10001;
const ECertificateBatchNotFound: u64 = 10001;
const ECertificateHashNotFound: u64 = 10002;
const EDuplicateHash: u64 = 10003;
const EInstitutionAlreadyRegisteres: u64 = 10004;
const EInvalidInputValue: u64 = 10005;
const ECertificateAlreadyRevoked: u64 = 10006;
const ENotAuthorized: u64 = 10007;
const ECertificateAlreadyUnrevoked: u64 = 10008;
const ECertificateHashCannotBeDeleted: u64 = 10009;
const EBatchNoLongerAcceptsHash: u64 = 10010;
const EHashCannotBeRemovedFromBatch: u64 = 10011;
const EInstitutionProfileMintedAlready: u64 = 10012;
const EKeyandHashLengthMismatch: u64 = 10013;
