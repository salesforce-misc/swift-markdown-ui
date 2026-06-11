# NetworkImageView (vendored)

Source vendored from [`gonzalezreal/NetworkImage`](https://github.com/gonzalezreal/NetworkImage) at tag `6.0.1` (commit `2849f5323265386e200484b0d0f896e73c3411b9`). MIT-licensed; original `LICENSE.txt` preserved alongside the source.

## Why vendored

The upstream package emits a public type named `NetworkImage<Content>` from a module also named `NetworkImage`. Under `BUILD_LIBRARY_FOR_DISTRIBUTION=YES` the emitted `.swiftinterface` references `NetworkImage.NetworkImageState` etc., where the leading `NetworkImage` is meant to be the module. Swift's interface verifier resolves the leading `NetworkImage` as the **type** instead, fails to find the inner names, and rejects the interface. The bug blocks any consumer that ships as an XCFramework with library evolution mode (notably AgentforceSDK's SPM binary distribution — see `iOS/AgentforceSDK#1455` and W-22471367).

The fix is to give the vendored copy a different module name (`NetworkImageView`) so the qualified names emitted in the swiftinterface (`NetworkImageView.NetworkImageState`) no longer collide with any type in scope.

The vendored sources are byte-for-byte unchanged from upstream so future re-vendoring stays straightforward (`cp`, no patching).

## Re-vendoring

To pick up a newer upstream:

```sh
cp -R <NetworkImage checkout>/Sources/NetworkImage/*.swift Sources/NetworkImageView/
cp <NetworkImage checkout>/LICENSE Sources/NetworkImageView/LICENSE.txt
```

Update the version reference at the top of this file.
