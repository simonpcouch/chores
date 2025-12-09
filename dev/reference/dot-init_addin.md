# Run the chores addin

The chores addin allows users to interactively select a chore helper to
interface with the current selection. **This function is not intended to
be interfaced with in regular usage of the package.** To launch the
chores addin in RStudio, navigate to `Addins > Chores` and/or register
the addin with a shortcut via
`Tools > Modify Keyboard Shortcuts > Search "Chores"`–we suggest
`Ctrl+Alt+C` (or `Ctrl+Cmd+C` on macOS).

## Usage

``` r
.init_addin()
```

## Value

`NULL`, invisibly. Called for the side effect of launching the chores
addin and interfacing with selected text.

## Examples

``` r
if (interactive()) {
  .init_addin()
}
```
