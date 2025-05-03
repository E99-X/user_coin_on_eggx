# 🥚 Eggx Token Sale Protocol - User Readme

## 🔧 Prerequisites

### ✅ Install Visual Studio Code
To get started, install [Visual Studio Code](https://code.visualstudio.com/).

To open the terminal inside VS:
- **Windows**: `Ctrl + Shift + P` → "Toggle Integrated Terminal"
- **Mac**: `Cmd + Shift + P` → "Toggle Integrated Terminal"

---

### ✅ Install SUI CLI
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

## 💳 Sui Wallet Setup

To interact with contracts via [Sui Explorer](https://suiexplorer.com/) or [Suiscan](https://suiscan.xyz/), install the [Sui Chrome Wallet](https://chromewebstore.google.com/detail/sui-wallet/).

You will import the wallet you generate via CLI:

> **Important:** Save the following details when you generate the wallet:
> - **Public Key**
> - **Recovery Phrase** (never share this!)

After importing into the Chrome wallet:
- Go to `Settings → Network` and switch to **Testnet**

---

## 🧚️ CLI Setup & Test Wallet

### 🚪 Create New Wallet via Terminal
```bash
sui client new-address ed25519
```
This will display:
- Your new SUI wallet address
- Your Recovery Phrase (save it securely!)

### 🔍 Check & Switch Wallet Address
```bash
sui client active-address
sui client switch --address <your_address>
```

### 🌐 Switch to Testnet
```bash
sui client switch --env testnet
```

### 💰 Get Testnet SUI Tokens
Use one of the following faucets to fund your wallet:
- [Faucet #1](https://faucet.sui.io/)
- [Faucet #2](https://faucet.n1stake.com/)

Then confirm funds:
```bash
sui client gas
```

---

## 💳 Create Your First Token on Sui

### 📁 Clone This Repo
Open VS Code → `Clone Git Repository`:
```bash
https://github.com/petushka1/user_coin_on_eggx
```

### 🧱 Build the Contracts
```bash
sui move build
```

### 🚀 Publish Contracts to Testnet
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

## 🔍 Finding Object IDs

### 🖥️ From Terminal
```bash
sui client objects
```
Look for:
- Your `TreasuryCap`
- TokenSale or AdminCap IDs (after launching sale)

### 🌐 From Explorer
1. Go to [Sui Explorer](https://suiexplorer.com/) or [Suiscan](https://suiscan.xyz/testnet/home)
2. Set network to **Testnet**
3. Paste your `Transaction Digest` (from publish) in the search bar
4. View:
   - `Package ID`
   - `TreasuryCap ID`
   - CoinType: `<PackageID>::<ModuleName>::<StructName>`

📦 **Example:**
```
CoinType: 0xb5ba8c3e...::usercoin::USERCOIN
TreasuryCap: 0xdba9692...
```

---

## 🚀 Launch Sale (Suiscan Web UI)

### 🧩 Connect Wallet to [Suiscan Testnet]([https://suiscan.xyz/testnet/home)
1. Open Chrome Wallet → "Add Account" → "Import Passphrase"
2. Paste your **Recovery Phrase**
3. Confirm with your wallet password
4. In `Settings → Network`, choose **Testnet**

### 📦 Launch Sale
1. Paste published EggX package ID `0x34218f8b8ed94c0c89bdf312188a612a9f9b2b4db6c70ff9c85e1ff52ea973c0` into search or click [here](https://suiscan.xyz/testnet/object/0x34218f8b8ed94c0c89bdf312188a612a9f9b2b4db6c70ff9c85e1ff52ea973c0/contracts) to open
2. Go to `Contracts` tab → Select `dashboard_utils`
3. Select `dashboard_launch_sale`

### 📄 Fill in the Fields:
| Field            | Description                                           | Example                       |
|------------------|-------------------------------------------------------|-------------------------------|
| `Type`           | Your CoinType                                         | `0x...::usercoin::USERCOIN`   |
| `Hard_cap`       | Max supply                                            | `120000000`                   |
| `Reserve_percentage` | Reserved for project team or treasury            | `25`                          |
| `Base_price`     | Price per token (fixed-point, 0.1 = `100000000`)      | `100000000`                   |
| `Number_of_stages` | How many stages                                     | `4`                           |
| `Stage_duration` | Days per stage                                        | `15`                          |
| `Pricing_mode`   | 0: static, 1: fixed step, 2: burn-scaled, 3: sold-scaled | `2`                        |
| `Pricing_param`  | Increment or factor (fixed-point, ex: `1.5 = 1500000000`) | `1500000000`             |
| `Final_mode`     | 0 = pool, 1 = burn                                    | `1`                           |
| `Treasury_cap`   | Your TreasuryCap ID                                   | `0xb144...`                   |

---

## ⚙️ Launch Sale via CLI

```bash
sui client call --package 0x34218f8b8ed94c0c89bdf312188a612a9f9b2b4db6c70ff9c85e1ff52ea973c0 --module dashboard_utils --function dashboard_launch_sale --args <hard_cap> <reserve_percentage> <price> <number_of_stages> <stage_duration> <pricing_mode> <pricing_param> <final_mode> <treasury_cap_id> --gas-budget 100000000 --type-args <your_token_type>
```

After launch, run:
```bash
sui client objects
```
Find your:
- `TokenSale Object ID`
- `AdminCap`

---

## ⏩ Advance Sale to Stage 1

### ⚙️ Advance Sale via Explorer

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

### ⚙️ Advance Sale via CLI

```bash
sui client call --package 0x34218f8b8ed94c0c89bdf312188a612a9f9b2b4db6c70ff9c85e1ff52ea973c0 --module sale_utils --function advance_sale --args <token_sale_id> <admin_cap_id> 0x6 --type-args <your_token_type> --gas-budget 100000000
```

🔀 `0x6` is the shared Sui Clock ID used for time-based logic.

---

## 📆 View Token Sale Objects
```bash
sui client object <token_sale_object_id> --json
```

---

## 💸 Buying Tokens

### 👉 Step 1: Prepare Payment
List your gas coins:
```bash
sui client gas
```

If you only have 1 coin object, **split it**:
```bash
sui client split-coin --coin-id <your_sui_coin_id> --amounts <amount_in_mist> --gas-budget 10000000
```

### 👉 Step 2: Buy Tokens (CLI)
1. `TokenSale ID`
2. `Amount` – number of tokens to buy, in fixed-point format (e.g. 100_000_000_000 for 100 tokens)
3. `SUI Coin ID` – this is your payment coin
4. `Clock` – always 0x6
6. `Type Argument` – your custom token type (e.g. 0x...::usercoin::USERCOIN)
```bash
sui client call --package 0x34218f8b8ed94c0c89bdf312188a612a9f9b2b4db6c70ff9c85e1ff52ea973c0 --module sale_utils --function buy_tokens --args <token_sale_id> <amount_in_fixed_point> <your_sui_coin_id> 0x6 --type-args <your_coin_type> --gas-budget 100000000
```

📌 `amount` is embedded into the coin you pay with (not passed separately).

---

## 🎨 Token Customization (Optional)

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

## 📄 `Move.toml`

```toml
[package]
name = "user_coin"
version = "0.0.1"
edition = "2024.beta"

[dependencies]
Sui = { git = "https://github.com/MystenLabs/sui.git", subdir = "crates/sui-framework/packages/sui-framework", rev = "framework/devnet", override = true }
eggx_test = { git = "https://github.com/petushka1/eggx.git", subdir = "move", rev = "develop" }

[addresses]
user_coin = "0x0"
eggx_test = "0x34218f8b8ed94c0c89bdf312188a612a9f9b2b4db6c70ff9c85e1ff52ea973c0"
```

---

## ✅ You're Ready!

You’ve now:
- Created a test wallet ✅
- Deployed a token ✅
- Launched a token sale ✅
- Bought tokens via CLI or Explorer ✅

---

**Happy hacking 🤪 and keep building with Eggx!**

