// user package
module user_coin::usercoinew2 {
    use eggx_test::token_utils::create_token;

    public struct USERCOINEW2 has drop {}

    fun init(witness: USERCOINEW2, ctx: &mut TxContext) {

        let treasury_cap = create_token<USERCOINEW2>(
            witness,
            9,
            b"User Token",
            b"UST",
            b"User Custom Token",
            option::none(),
            ctx,
        );
        transfer::public_transfer(treasury_cap, tx_context::sender(ctx));
    }
}