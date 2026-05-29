# Contributing to VibeShop

This document describes how to contribute to the VibeShop project.

## Educational project notice

VibeShop is an educational project created for an exam.

For this reason, we do not accept external pull requests that implement project functionality for us. The core code and project tasks must be completed by our own team.

At the same time, we welcome help in the form of:

- advice;
- testing;
- bug reports;
- design suggestions;
- security feedback;
- code review comments;
- general improvement ideas.

Please avoid submitting complete ready-made solutions for our tasks.

## Main rules

Do not commit directly to `main`.

All changes should be made through a separate branch and a pull request.

The standard workflow is:

```text
issue -> branch -> commit -> pull request -> review -> merge
```

## Branch naming

Use clear branch names.

Recommended format:

```text
feature/short-description
fix/short-description
docs/short-description
refactor/short-description
```

Examples:

```text
feature/login-page
feature/registration-page
feature/homepage-layout
fix/register-redirect
fix/login-navigation
docs/update-readme
docs/add-contributing-guidelines
refactor/shared-styles
```

## Commit messages

Use clear commit messages that describe what was changed.

Good examples:

```text
Add registration page layout
Fix login redirect
Update homepage styles
Add shared button styles
Improve mobile layout
```

Bad examples:

```text
fix
update
final
changes
test
new version
```

## Issues

Before starting work, create or choose an issue.

Each issue should describe:

- what needs to be done;
- why it is needed;
- what result is expected;
- which page or feature is affected.

Good issue examples:

```text
Add login page
Fix registration button redirect
Improve homepage mobile layout
Create product card component
Add cart page structure
```

Avoid unclear issues like:

```text
Fix site
Update page
Make better
```

## Pull requests

Each pull request should include:

- short description of changes;
- related issue;
- list of changed files or features;
- screenshots for UI changes;
- testing notes.

Do not include unrelated changes in one pull request.

For example, do not mix:

- login page changes;
- homepage layout changes;
- README updates;
- CSS refactoring;

inside one large pull request unless they are directly connected.

## Pull request description

Use this structure when opening a pull request:

```md
## Description

Briefly describe what was changed.

## Related issue

Closes #

## Changes

- 
- 
- 

## Testing

- [ ] Page opens correctly
- [ ] Navigation works
- [ ] Desktop layout checked
- [ ] Mobile layout checked

## Screenshots

Add screenshots if the pull request changes the interface.
```

## Code review

A pull request should be reviewed before merging into `main`.

During review, check:

- whether the feature works;
- whether the layout is not broken;
- whether navigation works correctly;
- whether desktop and mobile views are acceptable;
- whether file names are clear;
- whether the code is readable;
- whether no unrelated files were changed;
- whether no secrets or private data were committed.

## Local testing

Before opening a pull request, test:

- page loading;
- navigation between pages;
- forms;
- buttons;
- links;
- desktop layout;
- mobile layout;
- images and icons;
- CSS consistency.

If the project uses a local server, run it locally and check the changed pages in the browser.

## UI changes

For UI changes, add screenshots to the pull request.

Screenshots should show:

- desktop version;
- mobile version, if relevant;
- before/after comparison, if useful.

Do not merge UI changes without checking how they look in the browser.

## Security

Do not commit:

- passwords;
- API keys;
- tokens;
- database credentials;
- payment credentials;
- private user data;
- local configuration files with sensitive values.

If a feature is related to authentication, registration, user data, cart, orders, or payments, it should be reviewed especially carefully.

## Project structure

Keep files organized.

HTML/JSP pages should be placed in the correct project folders.

CSS should be reused where possible instead of duplicating the same styles for every page.

Use clear file names.

Good examples:

```text
login.html
registration.html
homepage.html
products.html
cart.html
style.css
auth.css
layout.css
```

Bad examples:

```text
page1.html
new.html
final.html
test.html
copy.html
```

## CSS rules

Try to avoid unnecessary duplication.

If several pages use the same style, place it in a shared CSS file.

Use meaningful class names.

Good examples:

```text
.page-header
.product-card
.login-form
.primary-button
.nav-link
```

Bad examples:

```text
.box1
.text2
.new-style
.test-class
```

## HTML rules

Keep HTML readable and structured.

Use semantic tags where appropriate:

```html
<header>
<nav>
<main>
<section>
<footer>
```

Use proper indentation.

Avoid leaving unused commented code in final pull requests.

## Documentation

Update documentation when a change affects:

- project setup;
- page structure;
- navigation;
- important functionality;
- development workflow.

Documentation should be clear enough for another team member to understand the project without guessing.

## External help policy

Since this is an educational exam project, external help should be limited to:

- explanations;
- recommendations;
- testing;
- bug reports;
- code review;
- security observations;
- general technical advice.

External contributors should not provide complete ready-made implementations of project tasks.

The final project implementation must remain the work of the project team.

## Final checklist before pull request

Before opening a pull request, make sure that:

- [ ] The project runs locally
- [ ] The changed page opens correctly
- [ ] Links and buttons were tested
- [ ] Desktop layout was checked
- [ ] Mobile layout was checked
- [ ] Screenshots were added for UI changes
- [ ] The pull request is linked to an issue
- [ ] No secrets were committed
- [ ] No unrelated files were changed
- [ ] The code is readable
- [ ] The change is ready for review
