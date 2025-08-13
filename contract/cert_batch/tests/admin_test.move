
#[test_only]
module learnchain::admin_test;

use learnchain::admin::{AdminCap, test_init};
const EUnauthorized: u64 = 10001;
use sui::test_scenario;

#[test]
fun init_admin() {
    // Create test addresses representing users
    let admin_address = @0xAD;
    // First transaction to emulate module initialization
    let mut scenario = test_scenario::begin(admin_address);
    {
       test_init(scenario.ctx());
    };

scenario.next_tx(admin_address);

{
    let cap = scenario.take_from_sender<AdminCap>();
    assert!(cap.get_name() == b"Admin Capability for Learnchain platform.".to_string(), 1);
    scenario.return_to_sender<AdminCap>(cap);
    };

    scenario.end();
}

