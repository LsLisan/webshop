# webshop

Simple Flutter sample mimicking a Daraz‑style product list.

---

## Run

```sh
flutter pub get
flutter run
```

No setup needed; data comes from [fakestoreapi.com](https://fakestoreapi.com/).

The pull-to-refresh uses a liquid-style animation (via
`liquid_pull_to_refresh`).

---

## Key scroll/gesture points

- **Single vertical owner:** outer `NestedScrollView`. Inner tabs use
  `CustomScrollView` only for layout and report via overlap.
- **Pull‑to‑refresh:** `RefreshIndicator` wraps the `NestedScrollView` so any
  downward swipe triggers it.
- **Sticky tabs:** `SliverPersistentHeader` pinned under a collapsing
  `SliverAppBar`.
- **Horizontal nav:** `TabBar`/`TabBarView` handle taps and swipes. `TabBarView`
  is a `PageView` that only captures horizontal drags (axis orthogonality
  prevents vertical conflict).

### Explanations

1. **Horizontal swipe** – implemented by `TabBarView` in the body; it takes
   precedence on x‑axis gestures, leaving y‑axis to the parent.
2. **Vertical scroll ownership** – the `NestedScrollView` holds the controller
   so all vertical movement is centralized. Inner scrolls do not have their
   own controllers.
3. **Trade‑offs** – offsets per tab are cached with `PageStorageKey` to
   prevent jumps. A "pure" single‑scroll solution would require manually
   combining all tab content into one `CustomScrollView`, which is more
   cumbersome and less idiomatic, so the current structure is a practical
   compromise.

Comments in source files add further detail.
