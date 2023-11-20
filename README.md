# Taylah_RxTextGame

A simple text game built using Rx and Observables in iOS Swift.

# Pods

- RxSwift
- RxCocoa
- RxDataSources

## Instructions

To play this game, select one of Up, Down, Left, Right to navigate through an invisible maze filled with traps and treasures.

https://github.com/taylahlucas/RxTextGame-iOS/assets/53559103/365303f2-9291-41ce-8b37-d677e87b9292

## Tasks

* On start, ask for the user name
* Update name to display the entered player name
* Update enabled/disabled state for buttons depending on what their next option is (if moving right would go no-where, the button should be disabled)
* Update description based on player position
* The action button should only be enabled if an action can be performed on that screen
* The user should have 3 statuses - `Healthy`, `Injured` & `Dead`
* If the player enters a trap:
  * If the player is `Healthy`, their status should change to `Injured`
  * If the player is `Injured`, their status should change to `Dead` and after a short delay, the app should transition to a `Game Over` screen (which should display the number of chests collected and the total number of chests) 
* When the player gets to the `Finish` space the app should transition to a `Congratulations` screen (which should display the number of chests collected and the total number of chests)
