# Co-inductive types in Elm

A way to implement "virtual class" in functional programming languages.

The core idea is defining the following type:

```elm
type Component
    = Unroll { update : () -> Component, render : () -> String }
```

## Component Example

In a game engine, you may have different kinds of components, each of them has its own datatype and update/render functions.

This repo tries to implement a *simple* component updater in Elm that updates different components.

Our goals are:

- Different components may use their own datatype (**NOT** exposed to our updater)
- We can design `Component` datatype for users but the type must not change when users are writing a component
- Component has a data of type `a`, an update function of type `a -> a`, and a render function of type `a -> String`

## Messages

We may want to add messages to let components react to different events.

However, a component may want to decide the message types by themselves (besides world events).

Please read the example to understand how this works.

Remember these three files belong to **diffrent** modules (may be in different libraries).

- `Comp1`: A component that can increase or decrease its own value. Note that `Comp1` is *independent* of `Main`
- `Comp`: A library to manage components, provided for both component designers and users
- `Main`: An end user who uses `Comp1`
