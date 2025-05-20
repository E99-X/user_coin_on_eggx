# 🥚 Eggx Token Sale Protocol - User Readme

This guide helps you create and launch a token sale on Sui using **Egg-X**, a modular, fully on-chain token sale protocol.
No backend. No servers. Just smart contracts and one handy CLI.
Use it to:

- ✅ Mint your own token
- ✅ Configure a live on-chain sale
- ✅ Launch & manage with a UI or CLI
- ✅ Embed the sale widget anywhere

---

- **Live Demo Playground**: [e99x.com](https://e99x.com/)
- **Social**: [@EggX\_](https://x.com/EggX_)

## 🔧 Prerequisites

### Install Visual Studio Code

To get started, install [Visual Studio Code](https://code.visualstudio.com/).

To open the terminal inside VS:

- **Windows**: `Ctrl + Shift + P` → "Toggle Integrated Terminal"
- **Mac**: `Cmd + Shift + P` → "Toggle Integrated Terminal"

---

### Install SUI CLI

To interact with the Sui blockchain, you'll need the SUI CLI.

Official docs:

- [SUI CLI Reference](https://docs.sui.io/references/cli/client)
- [Installation Guide](https://docs.sui.io/build/install)

**Quick install for macOS (via Homebrew):**

```bash
brew install sui
```

**Alternatively, install with npm:**

```bash
npm install -g sui
```

---

## CLI Setup & Test Wallet

### Create New Wallet via Terminal

```bash
sui client new-address ed25519
```

This will display:

- Your new SUI wallet address
- Your Recovery Phrase (save it securely!)

### Check & Switch Wallet Address

```bash
sui client active-address
sui client switch --address <your_address>
```

### Switch to Testnet

```bash
sui client switch --env testnet
```

### Get Testnet SUI Tokens

Use one of the following faucets to fund your wallet:

- [Faucet #1](https://faucet.sui.io/)
- [Faucet #2](https://faucet.n1stake.com/)

Then confirm funds:

```bash
sui client gas
```

---

## Slush Wallet Setup

To use [EggX Demo Playground](https://e99x.com/) as Token Sale admin you will need a Slush wallet installed and CLI generated wallet imported.
Also it is required to interact with contracts via [Sui Explorer](https://suiexplorer.com/)

- install the [Slush Wallet](https://chromewebstore.google.com/detail/slush-%E2%80%94-a-sui-wallet/opcgpfmipidbgpenhmajoajpbobppdil).

- Import (Passphrase) the wallet you generated via CLI

After importing into the Slush Chrome wallet:

- Go to `Current Account - Settings → Network` and switch to **Testnet**

---

## 1️⃣ Create Your First Token on Sui

### ⚠️ Make sure all your test tokens have **unique names per address**

> **MVP Constraint:** Prevents conflicts; each token name allows **one AdminCap**  
> Go to [Token Customization (Optional)](#token-customization-optional)

### Clone This Repo

Open VS Code → `Clone Git Repository`:

```bash
git clone https://github.com/E99-X/user_coin_on_eggx
cd user_coin_on_eggx
```

### Build the Contracts

```bash
sui move build
```

### Publish Contracts to Testnet

```bash
sui client publish --gas-budget 100000000
```

> If the publish fails, increase the gas budget or remove the `--gas-budget` flag entirely.

After successful publishing, terminal will show:

```
Published Objects:
PackageID: 0xYOUR_PACKAGE_ID
```

---

## Finding Object IDs

### From digest you see in Terminal find

- `TreasuryCap` ID
- `TokenType` in format `<PackageID>::<ModuleName>::<StructName>`

**Example:**

```
CoinType: 0xb5ba8c3e...::usercoin::USERCOIN
TreasuryCap: 0xdba9692...
```

Alternativly you can find the objects via [Suiscan](https://suiscan.xyz/testnet/home) or in your terminal:

```
sui client objects
```

## 2️⃣ Launch Sale via CLI

```bash
sui client call --package 0x023177c42f5ff2f00de27af9132c17143446df41148c4fd132a2f7569b8fffa0 --module dashboard_utils --function dashboard_launch_sale --args <hard_cap> <reserve_percentage> <price> <number_of_stages> <stage_duration> <pricing_mode> <pricing_param> <final_mode> <treasury_cap_id> --gas-budget 100000000 --type-args <your_token_type>
```

### Arguments

| Field                | Description                                              | Example                                 |
| -------------------- | -------------------------------------------------------- | --------------------------------------- |
| `hard_cap`           | Max supply                                               | `120000000`                             |
| `reserve_percentage` | Reserved for project team or treasury                    | `25`                                    |
| `price`              | Price per token                                          | `100000000` (fixed-point, 0.1 \* 10^9)  |
| `number_of_stages`   | How many stages                                          | `4`                                     |
| `stage_duration`     | Days per stage                                           | `15`                                    |
| `pricing_mode`       | 0: static, 1: fixed step, 2: burn-scaled, 3: sold-scaled | `2`                                     |
| `pricing_param`      | Increment or factor                                      | `1500000000` (fixed-point, 1.5 \* 10^9) |
| `final_mode`         | 0 = pool, 1 = burn                                       | `1`                                     |
| `treasury_cap_id>`   | Your TreasuryCap ID                                      | `0xb144...`                             |
| `your_token_type`    | Your CoinType                                            | `0x...::usercoin::USERCOIN`             |

---

## 3️⃣ Start and Manage Sale via UI

Once you've launched your first sale and found your **`TokenSale ID`** in dygest You can start testing Egg-X Widget as a creator.
Go to [EggX Demo Playground](https://e99x.com/), connect your wallet and follow intuitive UI

- Start Sale
- Advance stages once end time is arrived
- Set Sale to autopilot
- Copy your Widget `<script>` and try to place in html document or any Sandbox, for example [CodeSandbox](https://codesandbox.io)

### Widget Screenshots

<img src="https://i.imgur.com/9NDXTYM.jpeg" width="300" style="vertical-align: top;"/> <img src="https://i.imgur.com/T0TgLtx.jpeg" width="300" style="vertical-align: top;"/>

---

## 4️⃣ Manage Sale via CLI

To continue CLI/Explorer flow additionally to `TokenSale ID` you will be required:

- `AdminCap ID`
- `TokenType`

### ⚙️ Advance Sale via Explorer

```bash
sui client call --package 0x023177c42f5ff2f00de27af9132c17143446df41148c4fd132a2f7569b8fffa0 --module sale_utils --function advance_sale --args <token_sale_id> <admin_cap_id> 0x6 --type-args <your_token_type> --gas-budget 100000000
```

To start your Token Sale from the Explorer:

1. Open [Suiscan Devnet](https://suiscan.xyz/testnet/home) and connect your wallet.
2. Search for your **Package ID**, go to the `sale_utils` contract.
3. Select the `advance_sale` function.
4. Provide:
   - `TokenSale`: your TokenSale object ID
   - `AdminCap`: your AdminCap object ID
   - `Clock`: `0x6` (fixed value)
5. Set the **type argument**:
   `0x<your_package_id>::usercoin::USERCOIN`

This initializes your sale, splits the supply, and starts Stage 1 automatically.

> `0x6` is the shared Sui Clock ID used for time-based logic.

---

### View Token Sale Objects

```bash
sui client object <token_sale_object_id> --json
```

---

## 5️⃣ Buying Tokens via CLI

### Step 1: Prepare Payment

List your gas coins:

```bash
sui client gas
```

If you only have 1 coin object, **split it**:

```bash
sui client split-coin --coin-id <your_sui_coin_id> --amounts <amount_in_mist> --gas-budget 10000000
```

### Step 2: Buy Tokens (CLI)

1. `TokenSale ID`
2. `Amount` – number of tokens to buy, in fixed-point format (e.g. 100_000_000_000 for 100 tokens)
3. `SUI Coin ID` – this is your payment coin
4. `Clock` – always 0x6
5. `Type Argument` – your custom token type (e.g. 0x...::usercoin::USERCOIN)

```bash
sui client call --package 0x023177c42f5ff2f00de27af9132c17143446df41148c4fd132a2f7569b8fffa0 --module sale_utils --function buy_tokens --args <token_sale_id> <amount_in_fixed_point> <your_sui_coin_id> 0x6 --type-args <your_coin_type> --gas-budget 100000000
```

📌 `amount` is embedded into the coin you pay with (not passed separately).

---

## Token Customization (Optional)

Edit `/sources/user_coin.move`:

```move
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
```

✅ Rename both `module` and `struct` if changing your token name:

- `usercoin` → `yourname`
- `USERCOIN` → `YOURNAME`

---

## ✅ You're Ready!

You’ve now:

- Created a test wallet ✅
- Deployed a token ✅
- Launched a token sale ✅
- Bought tokens via CLI or Explorer ✅

---

**Happy hacking and testing!**
