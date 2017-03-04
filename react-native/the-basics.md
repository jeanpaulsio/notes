# The Basics
## Styling
* This is actually done with JAVASCRIPT and not CSS
* names are written with CamelCase
  - backgroundColor vs. background-color

```
import React, { Component } from 'react';
import { AppRegistry, StyleSheet, Text, View } from 'react-native';

class LotsOfStyles extends Component {
  render() {
    return(
      <View>
        <Text style={styles.red}>just red</Text>
        <Text style={styles.bigblue}>just bigblue</Text>
        <Text style={[styles.bigblue, styles.red]}>bigblue, then red</Text>
        <Text style={[styles.red, styles.bigblue]}>red, then bigblue</Text>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  bigBlue: {
    color: 'blue',
    fontWeight: 'bold',
    fontSize: 30,
  },
  red: {
    color: 'red',
  },
});

AppRegistry.registerComponent('LotsOfStyles', () => LotsOfStyles);
```

* A common pattern is to make a component accept a `style` prop which is used to style subcomponents

## Height and Width

* A Component's height and width determine its size on the screen

__Fixed Dimensions__

* All dimensions in React Native are unitless and represent density-independent pixels
* Setting dimensions using `width` and `height` will have objects render at exactly the same size, regardless of screen dimensions

```
import React, { Component } from 'react';
import { AppRegistry, View } from 'react-native';

class FixedDimensionBasics extends Component {
  render() {
    return (
      <View>
        <View style={{width: 50, height: 50, backgroundColor: 'powderblue'}} />
      </View>
    );
  }
}

AppRegistry.registerComponent('AwesomeProject', () => FixedDimensionsBasics);
```

__Flex Dimensions__

* We can also set sizing *dynamically*
* `flex: 1` tells a component to fill all available space
* The larger the `flex` given, the higher the ratio of space a component will take compared to it's siblings
* A component can only expand to fill available space, (it can only flex), if its parent dimensions have some sort of sizing dimensions

```
import React, { Component } from 'react';
import { AppRegistry, View } from 'react-native';

class FlexDimensionsBasics extends Component {
  render() {
    return(
      <View style={{flex: 1}}>
        <View style={{flex: 1}} />
        <View style={{flex: 2}} />
        <View style={{flex: 3}} />
      </View>
    );
  }
}

AppRegistry.registerComponent('AwesomeProject', () => FlexDimensionsBasics);
```

## Layout with Flexbox

* A component can specify the layout of its children using **flexbox**
* `flexDirection`, `alignItems`, `justifyContent`
* Flexbox works the same way as it does in CSS **with a few exceptions**
  - `flexDirection` defaults to `column` instead of `row`
  - `flex` parameter only supports a single number
*
