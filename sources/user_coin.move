// user package
module user_coin::usercoin {
    use eggx_test::token_utils::create_token;

    public struct USERCOIN has drop {}

    fun init(witness: USERCOIN, ctx: &mut TxContext) {

        let treasury_cap = create_token<USERCOIN>(
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