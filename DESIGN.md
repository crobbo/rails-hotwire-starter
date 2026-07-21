---
version: alpha
name: Quiet Utility
description: A calm, neutral, product-agnostic foundation for Rails applications.
colors:
  primary: "#2563EB"
  primary-hover: "#1D4ED8"
  on-primary: "#FFFFFF"
  canvas: "#F8FAFC"
  surface: "#FFFFFF"
  surface-subtle: "#F1F5F9"
  text: "#0F172A"
  text-muted: "#475569"
  border: "#CBD5E1"
  focus: "#2563EB"
  danger: "#DC2626"
  success: "#15803D"
  warning: "#B45309"
  canvas-dark: "#020617"
  surface-dark: "#0F172A"
  surface-subtle-dark: "#1E293B"
  text-dark: "#F8FAFC"
  text-muted-dark: "#CBD5E1"
  border-dark: "#334155"
typography:
  headline-lg:
    fontFamily: system-ui
    fontSize: 2.25rem
    fontWeight: 700
    lineHeight: 1.15em
    letterSpacing: -0.025em
  headline-md:
    fontFamily: system-ui
    fontSize: 1.875rem
    fontWeight: 700
    lineHeight: 1.2em
    letterSpacing: -0.02em
  headline-sm:
    fontFamily: system-ui
    fontSize: 1.5rem
    fontWeight: 600
    lineHeight: 1.25em
    letterSpacing: -0.015em
  body-lg:
    fontFamily: system-ui
    fontSize: 1.125rem
    fontWeight: 400
    lineHeight: 1.6em
  body-md:
    fontFamily: system-ui
    fontSize: 1rem
    fontWeight: 400
    lineHeight: 1.6em
  body-sm:
    fontFamily: system-ui
    fontSize: 0.875rem
    fontWeight: 400
    lineHeight: 1.5em
  label-lg:
    fontFamily: system-ui
    fontSize: 1rem
    fontWeight: 600
    lineHeight: 1.25em
  label-md:
    fontFamily: system-ui
    fontSize: 0.875rem
    fontWeight: 600
    lineHeight: 1.25em
  label-sm:
    fontFamily: system-ui
    fontSize: 0.75rem
    fontWeight: 600
    lineHeight: 1.25em
    letterSpacing: 0.025em
rounded:
  sm: 4px
  md: 8px
  lg: 12px
  full: 9999px
spacing:
  xs: 4px
  sm: 8px
  md: 16px
  lg: 24px
  xl: 32px
  xxl: 48px
components:
  page:
    backgroundColor: "{colors.canvas}"
    textColor: "{colors.text}"
    typography: "{typography.body-md}"
  page-dark:
    backgroundColor: "{colors.canvas-dark}"
    textColor: "{colors.text-dark}"
    typography: "{typography.body-md}"
  surface:
    backgroundColor: "{colors.surface}"
    textColor: "{colors.text}"
    rounded: "{rounded.lg}"
  surface-subtle:
    backgroundColor: "{colors.surface-subtle}"
    textColor: "{colors.text-muted}"
  surface-dark:
    backgroundColor: "{colors.surface-dark}"
    textColor: "{colors.text-dark}"
    rounded: "{rounded.lg}"
  surface-subtle-dark:
    backgroundColor: "{colors.surface-subtle-dark}"
    textColor: "{colors.text-muted-dark}"
  divider:
    backgroundColor: "{colors.border}"
    height: 1px
  divider-dark:
    backgroundColor: "{colors.border-dark}"
    height: 1px
  focus-ring:
    backgroundColor: "{colors.focus}"
    rounded: "{rounded.sm}"
  status-danger:
    textColor: "{colors.danger}"
    typography: "{typography.label-sm}"
  status-success:
    textColor: "{colors.success}"
    typography: "{typography.label-sm}"
  status-warning:
    textColor: "{colors.warning}"
    typography: "{typography.label-sm}"
  button-primary:
    backgroundColor: "{colors.primary}"
    textColor: "{colors.on-primary}"
    typography: "{typography.label-md}"
    rounded: "{rounded.md}"
    padding: 12px
  button-primary-hover:
    backgroundColor: "{colors.primary-hover}"
  input:
    backgroundColor: "{colors.surface}"
    textColor: "{colors.text}"
    typography: "{typography.body-md}"
    rounded: "{rounded.md}"
    height: 44px
  dialog:
    backgroundColor: "{colors.surface}"
    textColor: "{colors.text}"
    rounded: "{rounded.lg}"
    width: 32rem
---

# Quiet Utility

## Overview

Quiet Utility is a restrained, accessible starting point rather than a finished brand. It should feel calm, capable, and easy to adapt. Interfaces use moderate density, a clear hierarchy, cool neutral surfaces, and one action blue. Product-specific personality belongs in intentional changes to this document, not one-off overrides.

## Colors

Use cool slate neutrals for structure and reserve primary blue for links, focus, selection, and the most important action in a region. Semantic danger, success, and warning colors communicate state; they are not decoration. Light and dark surfaces have explicit tokens so both modes retain strong contrast.

## Typography

The system stack keeps the starter fast and platform-native. Headline, body, and label roles form a compact nine-level scale. Headlines are concise, body copy prioritizes reading comfort, and labels use weight rather than all-caps to establish hierarchy.

## Layout

Use a fluid layout with a readable fixed maximum width on larger screens. The spacing scale follows an 8px rhythm with a 4px half-step. Prefer whitespace, alignment, and dividers to excessive containers. Use 16px padding for compact groups, 24px for standard sections, and 32–48px between major page regions.

## Elevation & Depth

Create hierarchy primarily with tonal surfaces and thin borders. Keep ordinary content flat. Reserve subtle shadows for overlays, menus, dialogs, and elements that genuinely sit above the page.

## Shapes

Use 8px corners for controls, 12px for larger panels and overlays, and 4px for compact elements. Use the full radius only for status badges, tags, and other semantically pill-shaped elements.

## Components

Use Web Awesome for accessible interactive primitives and Tailwind for application layout and composition. Components inherit these tokens through the Web Awesome adapter. Keep Rails ViewComponent wrappers thin: expose application intent and slots while preserving the underlying Web Awesome API, keyboard behavior, events, CSS parts, and custom properties.

Web Awesome owns the document reset and base element styles. Tailwind imports its theme and utilities without Preflight because document-level reset declarations override custom-element `:host` styles, stripping layout from primitives such as badges.

The component catalogue uses concise examples that demonstrate each primitive's core behavior without duplicating upstream documentation. Full-page primitives are isolated in framed preview routes so responsive drawers and viewport behavior remain authentic without escaping into the catalogue page. API parity comes from using the upstream Web Awesome element directly, not from displaying every option at once.

- Primary buttons use the action blue and white text; hover darkens without changing layout.
- Inputs are at least 44px tall, with visible labels, muted help text, and a high-contrast focus ring.
- Dialogs are focused tasks, not general page containers. They own their accessible label, focus trap, Escape behavior, and restoration of focus.
- Navbars use familiar brand, link, and action regions. On narrow screens, links remain visible and horizontally scrollable rather than hiding essential navigation behind custom JavaScript.
- Menus use Web Awesome dropdown items for keyboard navigation, selection, checkable actions, and danger variants.
- Menus, popovers, tooltips, and disclosures should use Web Awesome behavior before custom JavaScript is considered.

## Do's and Don'ts

- Do update this file first when a design decision should apply across the product.
- Do maintain WCAG AA contrast and visible keyboard focus.
- Do use primary blue sparingly to preserve action hierarchy.
- Do use Tailwind utilities built from exported tokens for application composition.
- Don't edit generated theme CSS by hand.
- Don't recreate Web Awesome interaction behavior in Stimulus.
- Don't add a new color, radius, or spacing value for a single screen without first checking the existing scale.
- Don't use heavy shadows, glass effects, gradient text, decorative grid backgrounds, or grids of identical cards as a default visual language.
