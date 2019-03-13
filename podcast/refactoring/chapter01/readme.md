# Chapter 1 - Refactoring: Examples

## Extract Function (106)

When should you extract a function?

> The argument that makes the most sense to me, however, is the separation between intention and implementation. If you have to spend effort looking at a fragment of code and figure out what it's doing, then you should extract it into a function and name the function after the "what". Then, when you read it again, the purpose of the function leaps right out at you, and most of the time you won't need to care about how the function fulfills its purpose (which is the body of the function)

> Create a new function and name it after the intent of the function

```javascript
// code inside render function of react-native component
render() {
  const trackOneLength = positionOne;
  const trackOneStyle = twoMarkers
    ? unselectedStyle
    : selectedStyle || styles.selectedTrack;
  const trackThreeLength = twoMarkers ? sliderLength - positionTwo : 0;

  return () {
    //
  }
}
```

⬇️

```javascript
render() {
  function calculateMultiSliderTrackLengths({
    x1,
    x2,
    axisLength,
    markerSize
  }) {
    const trackBaseWidth = axisLength + markerSize;
    const trackLeftWidth = x1;
    const trackRightWidth = axisLength - x2;
    const trackSelectedWidth = axisLength - trackLeftWidth - trackRightWidth;

    return {
      trackBaseWidth,
      trackLeftWidth,
      trackRightWidth,
      trackSelectedWidth
    };
  }


  return () {
    //
  }
}
```

## Change Function Declaration (124)

Aka, rename the function

I want to highlight two things:

- 1. Good naming is important
- 2. not all "refactorings" have to be _huge_. Small changes can make big impact

```javascript
export function positionToValue(position, valuesArray, sliderLength) {
  var arrLength;
  var index;

  if (position < 0 || sliderLength < position) {
    return null;
  } else {
    arrLength = valuesArray.length - 1;
    index = (arrLength * position) / sliderLength;
    return valuesArray[Math.round(index)];
  }
}
```

⬇️

```javascript
/**
 * Calculates the nearest value in the array based on a given x coordinate.
 */
export function coordinateToValue({ coordinate, axisLength, values }) {
  if (coordinate < 0 || axisLength < coordinate) {
    return null;
  }

  const arrLength = values.length - 1;
  const index = (arrLength * coordinate) / axisLength;
  return values[Math.round(index)];
}
```

In this library, I changed all instances of `position` to `coordinate` - because everything is represented on a number line. Coordinate seemed more appropriate
