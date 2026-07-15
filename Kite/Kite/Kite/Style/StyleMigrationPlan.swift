//
//  StyleMigrationPlan.swift
//  Kite
//
//  Created by David Vasquez on 5/28/26.
//

/*
 # Plan: Adopt StyleDesignExample on Login (no code)

 Scope: LoginViewController and LoginLayoutManager only.
 Use Style/StyleDesignExample.swift as the pattern reference.
 Build new style APIs in Style/; leave Sort/ cleanup for later.
 Do not touch registration, friends, posts, or other screens yet.

 ---

 ## 1. Target pattern (from StyleDesignExample)

 Your example defines a repeatable flow:

 | Layer     | Responsibility                          | Login will use it for                    |
 |-----------|-----------------------------------------|------------------------------------------|
 | Colors    | Named tokens (UIColor extensions)       | #3797EF, #FAFAFA, borders, divider gray  |
 | Fonts     | Reusable font tokens                    | 14 regular, 16 semibold (login button)   |
 | Text      | Style a UILabel (font + color + lines)  | "Don't have an account?"                 |
 | Elements  | Style UIView / UITextField / divider    | Login text fields, optional divider lines|
 | Buttons   | Style UIButton after setTitle           | Log In, Forgot password?, Sign Up        |

 Screen structure (same as the example):

 1. Create view → set content (title, placeholder).
 2. Apply style → one call per layer (Text.*, Elements.*, Buttons.*).
 3. Constraints → layout only; no colors/fonts in constraint code.

 Responsibility split for login:

 - LoginViewController — lifecycle, delegate, loading indicator, navigation. No visual styling.
 - LoginLayoutManager — hierarchy, subviews, constraints, targets. Calls style APIs; no hardcoded hex/fonts.
 - Style/ — all look-and-feel tokens and static func appliers.

 ---

 ## 2. Current state (login-only audit)

 ### LoginViewController
 - Already thin: wires LoginLayoutManager, handles tap delegates and activityIndicator.
 - No styling work needed here except possibly view.backgroundColor if you want it explicit.

 ### LoginLayoutManager
 Today it mixes three approaches:

 | UI piece              | How it's styled today              | Target                    |
 |-----------------------|------------------------------------|---------------------------|
 | Username/password     | StyleOld.styleLoginTextField (Sort)| Elements.loginTextField   |
 | Log In button         | Inline #3797EF, corner radius      | Buttons.loginPrimary      |
 | Forgot password?      | Inline hex + system 14             | Buttons.loginLink         |
 | Sign Up               | Inline hex + bold 14               | Buttons.loginLinkBold     |
 | Register label        | Inline black + system 14           | Text.loginPrompt          |
 | Section containers    | .white, .lightGray footer          | Colors tokens (optional)  |
 | DividerWithLabel      | Hardcoded inside component         | Out of scope (see below)  |

 ### Dependencies to remove (from these two files only)
 - StyleOld.styleLoginTextField
 - Inline UIColor(hex: "#3797EF") and ad hoc UIFont in setupButtons / setupRegisterView

 ### Style folder reality check (before migrating login)
 - Colors.swift empty, Buttons.swift drifted, AppButtons/AppElements empty.
 - StyleDesignExample is the spec; implement real enums/files to match it.
 - UIColor(hex:) lives in AppColors.swift — keep hex parsing there; add login tokens.

 ---

 ## 3. Login UI inventory (build tokens from this list)

 Colors
 - Primary blue: #3797EF (login + link buttons)
 - Field background: #FAFAFA
 - Field border: black @ 10% opacity
 - Field text: black @ 80% opacity
 - Register prompt: black
 - Footer: light gray (decide if token or remove later)

 Typography
 - Field: SF Pro Text 14 regular; fallback .systemFont(14) if font missing
 - Login button: semibold 16
 - Forgot: regular 14
 - Sign up link: bold 14
 - Register prompt: regular 14

 Layout constants (stay in LoginLayoutManager, not style)
 - Field size 320x40, spacing 12/20, section height multipliers — unchanged until redesign.

 ---

 ## 4. Recommended Style/ structure for this pilot

 Style/
 ├── Colors.swift          ← login tokens (+ shared over time)
 ├── Fonts.swift           ← login font tokens
 ├── Text.swift            ← NEW: Text.loginPrompt(label:)
 ├── Elements.swift        ← extend: Elements.loginTextField(field:)
 ├── Buttons.swift         ← restore as enum; Buttons.loginPrimary, loginLink, etc.
 ├── StyleExtensions.swift ← UILabel helpers if needed (optional)
 ├── StyleDesignExample.swift  ← living doc / reference
 └── Sort/                 ← do not delete yet; stop new calls from login

 Naming: Use StyleDesignExample names (Text, Elements, Buttons enums) for this pilot.
 Merge to App* later if you want one convention app-wide.

 ---

 ## 5. Phased migration plan

 ### Phase 0 — Decisions (no code in login yet)
 1. Confirm login is the first screen on the new system.
 2. Font fallback: SFProText-Regular vs system font.
 3. Footer gray: intentional UI or debug scaffolding.
 4. DividerWithLabel: unchanged for now, or phase 1b.

 ### Phase 1 — Build login style APIs (Style folder only)
 Reproduce current pixels (no visual redesign):

 1. Colors — loginPrimary, loginFieldBackground, loginFieldBorder, loginFieldText, etc.
 2. Fonts — loginField, loginButton, loginLink, loginLinkBold, loginPrompt.
 3. Elements — port StyleOld.styleLoginTextField → Elements.loginTextField.
 4. Buttons — port inline login + link styles from layout manager.
 5. Text — register prompt label style.

 Acceptance: scratch VC or snapshot; each API matches current login. Use StyleDesignExample as checklist.

 ### Phase 2 — Refactor LoginLayoutManager (behavior unchanged)

 1. setupTextFields — StyleOld → Elements.loginTextField; remove dev defaults when ready.
 2. setupButtons — setTitle then Buttons.loginPrimary / Buttons.loginLink; delete inline hex/fonts.
 3. setupRegisterView — Text.loginPrompt + Buttons.loginLinkBold (or shared link).
 4. Section backgrounds (optional) — .white / .lightGray → color tokens.

 LoginViewController: verify same layout manager calls; no style imports.

 ### Phase 3 — Verify and lock the pattern
 - Launch login: fields, button, links, divider, register row unchanged.
 - Tap targets: login, forgot, sign up.
 - Keyboard / secure entry unchanged.
 - Build: no StyleOld references from LoginLayoutManager.
 - Document in StyleDesignExample: "Login reference → LoginLayoutManager."

 ### Phase 4 — Sort folder (later)
 - Grep StyleOld.styleLoginTextField → RegistrationStyleManager only after registration migrates.
 - Do not bulk-delete Sort/ until nothing references it.

 ---

 ## 6. Method-level mapping

 LoginLayoutManager:
 - setupViews — hierarchy, logo; section bg → tokens (optional)
 - setupConstraints — anchors only
 - setupTextFields — placeholders, secure entry, constraints; appearance → Elements
 - setupButtons — titles, targets, constraints; colors/fonts → Buttons
 - setupRegisterView — copy, targets, constraints; label/button → Text / Buttons
 - setupDividerView — layout only; DividerWithLabel styling is future

 LoginViewController:
 - viewDidLoad — no change
 - setupElements — activity indicator only
 - Delegate methods — no change

 ---

 ## 7. Rules while developing

 1. No new StyleOld / Sort/ usage from login files.
 2. No inline hex in LoginLayoutManager after Phase 2.
 3. Style functions never set titles — caller sets "Log In", then Buttons.loginPrimary(button:).
 4. One concern per file — tokens in Colors/Fonts; composition in Text/Elements/Buttons.
 5. Layout manager never imports Sort.
 6. Constraints stay in layout manager; no spacing in style APIs yet.

 ---

 ## 8. Risks and open questions

 - Duplicate StyleOld: Style.swift commented + Sort/StyleOld.swift active → login stops calling; delete Sort later.
 - Buttons.swift wrong type (UIViewController) → fix in Phase 1.
 - UIColor(hex:) in AppColors vs Colors.swift → decide once.
 - DividerWithLabel still old styles → phase 1b or accept briefly.
 - Registration shares styleLoginTextField → reuse Elements.loginTextField; don't fork.
 - Dev credentials in fields → remove when touching setupTextFields.

 ---

 ## 9. Success criteria

 - LoginLayoutManager: zero StyleOld, zero inline #3797EF / #FAFAFA.
 - Login looks the same (screenshot or simulator).
 - New style APIs for every login control type.
 - StyleDesignExample documents pattern; login is first real consumer.
 - Sort/ untouched except no new login dependencies.

 ---

 ## 10. Out of scope

 - RegistrationStyleManager, RegistrationViewController
 - DividerWithLabel.swift (unless phase 1b)
 - Deleting or reorganizing Sort/
 - Post/profile/friends styling
 - Storyboard changes

 ---

 ## Suggested order of work

 Phase 1: login tokens + Text / Elements / Buttons from today's visuals
 → Phase 2: swap calls in LoginLayoutManager only
 → Phase 3: test; document login as reference screen
 → Phase 4: migrate registration; retire StyleOld in Sort

 */
