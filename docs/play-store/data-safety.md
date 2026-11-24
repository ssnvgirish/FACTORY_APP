# Google Play Data safety form: answers for Prabitha QC

Use these as a starting point in Play Console → App content → Data safety. Check each answer against the actual build before submitting, and review it again whenever a feature changes.

## Overview

| Question | Answer |
|---|---|
| Does your app collect or share any of the required user data types? | **Yes** |
| Is all of the user data collected by your app encrypted in transit? | **Yes** (HTTPS / TLS to Firebase) |
| Do you provide a way for users to request that their data is deleted? | **Yes**, by contacting the administrator or the privacy contact in the privacy policy. Make sure the privacy policy URL is provided. |

## Data types

| Data type (Play category) | Collected | Shared | Optional | Purpose | Notes |
|---|---|---|---|---|---|
| Personal info → **Name** | Yes | No | No | Account management, App functionality | Staff name |
| Personal info → **Phone number** | Yes | No | No | Account management | Used as the login identifier |
| Personal info → **User IDs** | Yes | No | No | Account management, App functionality | Firebase Auth user ID and legacy user ID |
| App activity → **Other user-generated content** | Yes | No | No | App functionality | Production, quality, maintenance and salary reports |
| App info and performance → **Diagnostics** | No | No | — | — | No crash reporting SDK is included (Crashlytics not used) |
| App activity → **App interactions / Analytics** | No | No | — | — | No analytics SDK is included |
| Financial info → **Salary-related data** | Yes | No | No | App functionality | Salary calculations are stored. Play may ask whether this is "Other financial info" and it should be declared. |
| Location, contacts, photos, audio, messages, files, calendar, health, web browsing, device IDs | No | — | — | — | Not collected |

Note: the app stores work records and salary calculations under each staff member's user ID. Declare "Financial info → Other financial info" for the salary data if the form shows it.

## Security practices

- Data is encrypted in transit: **Yes**.
- Users can request deletion: **Yes** (see privacy policy section 7).
- Committed to Google Play Families Policy: **Not applicable**. The app is for employees only and is not directed at children.
- Independent security review: **No**, unless you commission one.

## Other Play Console items that go with this

- **Privacy policy URL:** the public URL of `privacy-policy.md` once hosted.
- **App access:** provide a test login, because the app requires sign-in. Create a dedicated test account in the admin panel and give Google the phone number and password. Google reviewers need this to see the app.
- **Target audience:** adults (18+). Not designed for children.
- **Content rating:** complete the IARC questionnaire. The app has no user-generated public content, no violence, and no purchases.
- **Ads:** No, the app does not contain ads.
- **Permissions:** the app only requests `INTERNET`. No other permission declarations are needed.

## Before you submit

1. Host `privacy-policy.md` and fill in the bracketed placeholders.
2. Create a test account for App access and record its credentials in your password manager.
3. Confirm the release build has no analytics or crash SDKs (`flutter pub deps` should not list any).
4. Re-check the answers if `shared_preferences` or `connectivity_plus` are used in a future release (both are in `pubspec.yaml` but not currently used in `lib/`).
