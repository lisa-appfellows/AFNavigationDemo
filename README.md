# AFNavigationDemo

A SwiftUI news-feed app whose purpose is to show how a real product consumes [AFNavigationKit](https://github.com/lisa-appfellows/AFNavigationKit). The feed, articles, and ads are scaffolding. The interesting part is the routing: typed destinations, opt-in presentation paths, nested coordinators, and queued alerts.

**AFNavigationKit:** 2.0.0  
**Platform:** iOS 17.2+

## How the package is added

The demo depends on AFNavigationKit as a remote Swift package, not a local path:

- **Repository:** `https://github.com/lisa-appfellows/AFNavigationKit.git`
- **Requirement:** up to next major from `2.0.0`
- **Product:** `AFNavigationKit` is linked to the `AFNavigationDemo` app target

That pin lives in `AFNavigationDemo.xcodeproj` (`XCRemoteSwiftPackageReference`) and is resolved in `AFNavigationDemo.xcodeproj/project.xcworkspace/xcshareddata/swiftpm/Package.resolved`.

Open `AFNavigationDemo.xcodeproj` in Xcode and run the **AFNavigationDemo** scheme.

## What the kit is used for

AFNavigationKit separates **what** you navigate to from **how** it is presented:

| Kit type | Role in this app |
| --- | --- |
| `ValidRoute` | Destination enums (`Page`, `Cover`, `Sheet`, `ArticleSheet`) |
| `DisabledRoute` | Turns off a presentation path a coordinator does not need |
| `RouteFactory` | Builds the SwiftUI view for a route |
| `BasicCoordinator` | Owns path / cover / sheet / alert state |
| `AlertModel` / `AlertAction` | Alert payloads presented through the coordinator |
| `openAlert(_:)` | Attaches the coordinator’s alert presenter to a view |

The app defines three coordinators. Each one opts into only the paths it uses:

| Typealias | Definition | Enabled paths |
| --- | --- | --- |
| `Coordinator` | `BasicCoordinator<Page, Cover, Sheet>` | Pages, covers, and sheets |
| `ArticleCoordinator` | `BasicCoordinator<DisabledRoute, DisabledRoute, ArticleSheet>` | Sheets only |
| `TargetAdCoord` | `BasicCoordinator<DisabledRoute, DisabledRoute, DisabledRoute>` | Alerts only |

That last case is the point of `DisabledRoute`: a coordinator can still present alerts when it has no navigation stack, cover, or sheet of its own.

## Where consumption lives

### 1. App entry

`AFNavigationDemoApp` hosts a single `CoordinatorView`. That view owns the root coordinator and is the first place the kit is wired into SwiftUI.

```swift
typealias Coordinator = BasicCoordinator<Page, Cover, Sheet>
```

`CoordinatorView` binds kit state to the three system presenters, then injects the coordinator into the environment so screens do not own routing:

```swift
NavigationStack(path: $coordinator.path) {
    NewsFeed()
        .navigationDestination(for: Page.self) { page in
            PageFactory.createView(for: page)
        }
        .fullScreenCover(item: $coordinator.cover) { cover in
            CoverFactory.createView(for: cover)
        }
        .sheet(item: $coordinator.sheet) { sheet in
            SheetFactory.createView(for: sheet)
        }
}
.environment(coordinator)
```

| File | What it does with the kit |
| --- | --- |
| `CoordinatorView/CoordinatorView.swift` | Creates `Coordinator`, binds `path` / `cover` / `sheet`, injects the environment |
| `CoordinatorView/Routes.swift` | `Page`, `Cover`, and `Sheet` as `ValidRoute` |
| `CoordinatorView/RouteFactories.swift` | `PageFactory`, `CoverFactory`, `SheetFactory` as `RouteFactory` |

### 2. Typed routes

Routes are small enums. Each presentation style has its own type so a cover destination cannot be pushed as a page by accident.

```swift
enum Page: ValidRoute {
    case categoryFeed(String)
}

enum Cover: ValidRoute {
    case articlePage(Article)
}

enum Sheet: ValidRoute {
    case targetedAd(urlString: String)
}
```

`id` on each case is required by `Routable` (`Identifiable` + `Hashable`) and is what SwiftUI uses to distinguish presented items.

### 3. Factories

Factories are the only types that know which view a route should build. Coordinators never import those views.

| Factory | Route | View |
| --- | --- | --- |
| `PageFactory` | `.categoryFeed` | `CategoryFeed` |
| `CoverFactory` | `.articlePage` | `ArticleCoordinatorView` (nested coordinator) |
| `SheetFactory` | `.targetedAd` | `TargetedAdCoordinator` wrapping a registered ad |

`SheetFactory` resolves `urlString` through `TargetedAdRegistry` (`/subscription` or `/baselineJoy`). An unknown URL produces `EmptyView()`.

### 4. Triggering navigation from screens

Most screens import **SwiftUI only**. They read `Coordinator` from the environment and call kit APIs:

| Screen | Call | Destination |
| --- | --- | --- |
| `NewsFeedSection` | `coordinator.push(page: .categoryFeed(category))` | Category list |
| `NewsFeedSection` | `coordinator.present(cover: .articlePage(article))` | Article cover |
| `NewsFeed` | `coordinator.present(sheet: .targetedAd(urlString:))` | Subscription sheet |
| `CategoryFeed` | `coordinator.present(cover:)` / `present(sheet:)` | Article cover or Baseline Joy sheet |

`NewsFeed` uses the default targeted ad (subscription). `PageFactory` overrides the environment for category feeds so those screens present Baseline Joy instead.

## Nested coordinators

A fullscreen cover gets its own coordinator. That is how the demo shows independent routing scopes: the article cannot push on the feed stack, and dismissing the cover does not depend on feed sheet state.

### Article cover — sheets only

`ArticleCoordinatorView` wraps `ArticlePage` in a new `NavigationStack` and a coordinator that disables pages and covers:

```swift
typealias ArticleCoordinator = BasicCoordinator<DisabledRoute, DisabledRoute, ArticleSheet>
```

`ArticlePage` then presents ads through that nested coordinator:

```swift
articleCoordinator.present(sheet: .targetedAd(urlstring: targetedAd.adURL))
```

| File | What it does with the kit |
| --- | --- |
| `ArticlePage/ArticleCoordinatorView.swift` | `ArticleCoordinator`, `ArticleSheet`, `ArticleSheetFactory` |
| `ArticlePage/ArticlePage.swift` | Reads `ArticleCoordinator` from the environment and presents the ad sheet |

### Ad sheets — alerts only

Each ad is hosted by `TargetedAdCoordinator`, which disables every navigation path and attaches the kit’s alert modifier:

```swift
typealias TargetAdCoord = BasicCoordinator<DisabledRoute, DisabledRoute, DisabledRoute>

NavigationStack {
    adContent()
}
.openAlert(targetAdCoord)
.environment(targetAdCoord)
```

Ad view models build `AlertModel` / `AlertAction` values. The views observe those models and forward them to the coordinator:

```swift
targetAdCoord.present(alert: newAlert)
```

| File | What it does with the kit |
| --- | --- |
| `TargetedAdView/TargetedAdCoordinator.swift` | Alert-only coordinator + `openAlert` |
| `TargetedAdView/TargetedAds/BaselineJoy/BaselineJoyViewModel.swift` | Builds `AlertModel` for CTA taps |
| `TargetedAdView/TargetedAds/Subscription/SubscriptionSignUpViewModel.swift` | Builds subscribe / restore / dismiss alerts |
| `TargetedAdView/TargetedAds/BaselineJoy/BaselineJoyAd.swift` | Forwards alerts to `TargetAdCoord` |
| `TargetedAdView/TargetedAds/Subscription/SubscriptionSignUpView.swift` | Forwards alerts to `TargetAdCoord` |

## Navigation map

```
CoordinatorView                    BasicCoordinator<Page, Cover, Sheet>
└─ NewsFeed
   ├─ push .categoryFeed        →  CategoryFeed
   │                                ├─ present .articlePage
   │                                └─ present .targetedAd  →  Baseline Joy
   ├─ present .articlePage      →  ArticleCoordinatorView
   │                                BasicCoordinator<DisabledRoute, DisabledRoute, ArticleSheet>
   │                                └─ ArticlePage
   │                                   └─ present .targetedAd  →  ad sheet
   └─ present .targetedAd       →  TargetedAdCoordinator
                                    BasicCoordinator<DisabledRoute, DisabledRoute, DisabledRoute>
                                    ├─ SubscriptionSignUpView   (alerts)
                                    └─ BaselineJoyAd            (alerts)
```

Try these flows in the simulator:

1. **Push** — News Feed → “See all … posts”
2. **Cover** — tap any article card
3. **Sheet from feed** — News Feed banner → Subscribe
4. **Sheet from category** — category feed banner → Baseline Joy
5. **Nested sheet** — open an article, then tap the in-article ad
6. **Alert** — tap an ad CTA, or change the subscription plan and close

## Kit types vs demo types

Files that `import AFNavigationKit` are the consumption surface. Everything else is product UI.

```
AFNavigationDemo/
├── CoordinatorView/          ← root routes, factories, and coordinator
├── ArticlePage/              ← nested sheet-only coordinator
└── TargetedAdView/
    ├── TargetedAdCoordinator.swift   ← alert-only coordinator
    └── TargetedAds/                  ← AlertModel producers
```

For the kit’s own API reference, see [AFNavigationKit Documentation](https://lisa-appfellows.github.io/AFNavigationKit/documentation/afnavigationkit/).

## License

Copyright © 2026 Lisa Fellows. All rights reserved. See [LICENSE.md](LICENSE.md).
