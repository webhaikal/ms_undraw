# undraw/UnDraw

UnDraw is a Flutter widget that provides [1285+ illustrations](https://undraw.co/illustrations), designed by [Katerina Limpitsouni](https://twitter.com/ninalimpi) forked from [westdabestdb](https://github.com/westdabestdb/undraw)

## Disclaimer

The reason of this library is because initial library is outdated, and a lot of new illustrations is been released.

![](https://media.giphy.com/media/MBf2NBhUXaEufSZFfa/giphy.gif)

## Usage

``` dart
UnDraw(
  color: Colors.red,
  illustration: UnDrawIllustration.mobile_application,
  placeholder: Text("Illustration is loading..."), //optional, default is the CircularProgressIndicator().
  errorWidget: Icon(Icons.error_outline, color: Colors.red, size: 50), //optional, default is the Text('Could not load illustration!').
)
```
