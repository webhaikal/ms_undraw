# undraw/UnDraw

[![Pub](https://img.shields.io/pub/v/ms_undraw.svg)](https://pub.dartlang.org/packages/ms_undraw)
[![GitHub stars](https://img.shields.io/github/stars/Marcus-Software/ms_undraw?style=social)](https://github.com/Marcus-Software/ms_undraw)
<span class="badge-buymeacoffee">
<a href="https://www.buymeacoffee.com/marcusedu" title="Donate to this project using Buy Me A Coffee"><img src="https://img.shields.io/badge/buy%20me%20a%20coffee-donate-yellow.svg" alt="Buy Me A Coffee donate button" /></a>
</span>

UnDraw is a Flutter widget that provides [1291+ illustrations](https://undraw.co/illustrations), designed by [Katerina Limpitsouni](https://twitter.com/ninalimpi) forked from [westdabestdb](https://github.com/westdabestdb/undraw)

## Disclaimer

The reason of this library is that initial library is outdated, and a lot of new illustrations has been released.

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

[See another libs here](https://pub.dev/publishers/marcussoftware.info/packages)
