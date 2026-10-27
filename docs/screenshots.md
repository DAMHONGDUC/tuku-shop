# Screenshots

Captured on an iPhone 17 Pro Max simulator from a fresh install (demo account signed in, seeded data).

## Shopping flow

| | |
|---|---|
| ![Home](../screenshots/01-home.jpg)<br>01 · Home | ![Categories](../screenshots/02-categories.jpg)<br>02 · Categories tab |
| ![Category products](../screenshots/03-category-products.jpg)<br>03 · Category products | ![Product detail](../screenshots/04-product-detail.jpg)<br>04 · Product detail |
| ![Add to cart](../screenshots/05-add-to-cart-sheet.jpg)<br>05 · Add-to-cart sheet | ![Cart](../screenshots/06-cart.jpg)<br>06 · Cart |
| ![Checkout](../screenshots/07-checkout.jpg)<br>07 · Checkout | ![Voucher](../screenshots/08-checkout-voucher.jpg)<br>08 · Voucher `TUKU10` applied |
| ![Order success](../screenshots/09-order-success.jpg)<br>09 · Order placed | ![Order detail](../screenshots/10-order-detail.jpg)<br>10 · Order detail with timeline |

## Account

| | |
|---|---|
| ![Profile](../screenshots/11-profile.jpg)<br>11 · Profile | ![My orders](../screenshots/12-my-orders.jpg)<br>12 · My orders |
| ![Wishlist](../screenshots/13-wishlist.jpg)<br>13 · Wishlist | ![Notifications](../screenshots/14-notifications.jpg)<br>14 · Notifications |
| ![Search](../screenshots/15-search.jpg)<br>15 · Search (trending, recommended) | ![Search results](../screenshots/16-search-results.jpg)<br>16 · Search results |

## Loading, dark mode, Vietnamese

| | |
|---|---|
| ![Skeleton](../screenshots/00-loading-skeleton.jpg)<br>00 · Home sections load one by one | ![Checkout loading](../screenshots/00-checkout-sections-loading.jpg)<br>00 · Checkout sections load one by one |
| ![Dark home](../screenshots/17-dark-home.jpg)<br>17 · Dark home | ![Dark product](../screenshots/18-dark-product.jpg)<br>18 · Dark product detail |
| ![Vietnamese profile](../screenshots/19-vi-profile.jpg)<br>19 · Profile (vi) | ![Vietnamese cart](../screenshots/20-vi-cart.jpg)<br>20 · Cart (vi) |
| ![Login](../screenshots/21-vi-login.jpg)<br>21 · Login (vi) | ![Register](../screenshots/22-vi-register.jpg)<br>22 · Register (vi) |

## Demo walkthrough

About 5 minutes. Start from **Profile → Reset demo data** so every run shows the same data.

| # | Do | Point out |
|---|---|---|
| 1 | Launch the app | Already signed in as the demo user; home sections appear one by one (200–800 ms mock latency each) |
| 2 | Swipe the banner, tap a category chip | Banners link to categories; list has sort and paging |
| 3 | Open a product | Gallery, color and size picker, sold-out sizes struck through, reviews, related items |
| 4 | Tap the heart, then **Add to cart** | Wishlist and cart badges update at once (optimistic, rolled back on failure) |
| 5 | Open the **Cart** tab, change a quantity | Quantity capped at stock; free-shipping hint over $100 |
| 6 | **Checkout** | Address, shipping, payment and items load as separate sections |
| 7 | Enter `TUKU10` (10% off) or `FREESHIP`; try `NOPE` | Invalid code shows an error that clears as you type |
| 8 | **Place order** | Success screen, cart emptied, new notification on the bell |
| 9 | **Track order** | Timeline; cancel with confirmation while "To confirm" |
| 10 | Bell on Home | Filter chips; tapping an order update opens that order |
| 11 | Search `dress` | Recent and trending searches, debounced results |
| 12 | **Profile → Appearance → Dark**, **Language → Tiếng Việt** | Whole app re-themes and switches language live |
| 13 | **Log out**, then sign in | Demo credentials are prefilled; Register validates the form |

| Demo value | |
|---|---|
| Account | `demo@tukushop.com` / `Demo@123` |
| Vouchers | `TUKU10` (10% off), `FREESHIP` (free standard shipping) |
| Shipping | Standard $4.99 (free over $100), Express $12.99 |
