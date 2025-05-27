# EggX TokenSale Widget

### Domain and Social Media

- **Domain**: [e99x.com](https://e99x.com/)
- **Social**: [@EggX\_](https://x.com/EggX_)

A drop-in React component that lets you embed on-chain TokenSale + Autopilot functionality into any site—no backend required.

---

## Deployment

Refer in your script:

```
https://widget.e99x.com/widget.js
```

## Overview

This widget allows anyone to embed a fully on-chain token sale powered by the EggX protocol directly into any website. It includes:

- Token Sale Widget with live sale and statistics
- Color & avatar customization
- Autopilot integration
- Admin panel auto-detection for deployers
- Sale and Stage management

> You need only to pass:
>
> - `saleId`
> - `avatarUrl`
> - `customColors`
>
> The widget will automatically fetch the token type and AdminCap ID from your wallet if you are recorded as an owner inside the tokenSale and let you manage the sale inside a built-in admin panel.

Token and Token Sale object can be created following the guidelines: [https://github.com/E99-X/user_coin_on_eggx/README.md](https://github.com/E99-X/user_coin_on_eggx)

Try the widget instantly at:

## [Live Demo](https://e99x.com/)

## Usage

```html
<div id="previewWidget-1"></div>
<script src="https://widget.e99x.com/widget.js"></script>
<script>
  window.TokenSaleWidget({
    containerId: "previewWidget-1",
    customColors: {
      primaryColor: "#dfdfdf",
      bgrColor: "#1c1c1e",
      accentColor: "#f8df00",
    },
    avatarUrl: "",
    saleId: "0xYourTokenSaleID",
  });
</script>
```

To render multiple widgets on the same page, just add more containers (with unique IDs) and call TokenSaleWidget again:

```html
<div id="previewWidget-1"></div>
<div id="previewWidget-2"></div>
<script src="https://widget.e99x.com/widget.js"></script>
<script>
  window.TokenSaleWidget({ containerId: "previewWidget-1" /* … */ });
  window.TokenSaleWidget({ containerId: "previewWidget-2" /* … */ });
</script>
```

---

## Behavior

- Entire Egg-X protocol logic implemented including autopilot
- Once Sale started widget allows connect wallet and buy token at current stage price
- If the connected wallet is the admin of a tokenSale, the widget exposes admin controls automatically.
- Sale config like tokenType and AdminCapId are auto-injected from chain state.
- Only UI-level config needed: avatar and colors.

### Autopilot Module (FaaS)

> Automate your token sale stages without signing manual transactions on specified triggers — EggX’s “Features as a Service” approach.

EggX Autopilot is a plug-and-play FaaS module—simply wire in a 10-minute cron job or serverless scheduler (e.g. Firebase Functions) and let your sale run itself on Sui.

## 📷 Screenshots

<img src="https://i.imgur.com/9NDXTYM.jpeg" width="300" style="vertical-align: top;"/> <img src="https://i.imgur.com/T0TgLtx.jpeg" width="300" style="vertical-align: top;"/>

## License

© 2025 Egg-X. All rights reserved

---

Built for autopilot-powered TokenSales on Sui by the EggX team.
