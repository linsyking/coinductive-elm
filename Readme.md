# Co-inductive types in Elm

A way to implement "virtual class" in functional programming languages.

The core idea is defining the following type:

```elm
type Component
    = Unroll { update : () -> Component, render : () -> String }
```
