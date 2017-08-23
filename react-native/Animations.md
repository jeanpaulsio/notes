## Create a Draggable Card

1. Import `Animated, PanResponder` from react-native
2. Create an instance of PanResponder in cwm
3. *Find the view that we want to add touch events to*
4. spread your instance of the PanResponder's panhandlers into this view
5. create your new Animated.ValueXY()
6. the function for `onPanResponderMove` becomes Animated.event()
7. This function takes an array
8. Animated.event traverses all of its arguments AND assigns those arguments to our AnimatedValues that we pass in
9. null the first argument; second argument is an object that we'll pass dx and dy to. we get these values from this.animatedValue.x and this.animatedValue.y
10. Turn your View into Animated.View
11. create your animatedStyle, transform: this.animatedValue.getTranslateTransform()
12. Attach this style to Animated.View
13. reset this new value to an object of { x: 0, y: 0 } when you instantiate it
14. Attach a listener, `this.animatedValue.addListener` assign result to the value you just instantiated
15. onPanResponderGrant, setOffset of this.animatedValue to an object that takes an x and y value using the resetted value
16. then setValue against animatedValue to x:0, y:0
17. onPanResponderRelease, call flattenOffset on our animatedValue
18. call Animated.decay with our animatedValue with an object of deceleration: 0.997 and an object called velocity that has an x and y
19. we get the x and y from gestureState.vx and .vy
20. dont forget to call start on decay function

# Interpolation
## Animate Colors
1. cwm create new Animated.Value
2. inside render, create a variable called `interpolateColor` and set it to the animated value that calls a function `.interpolate`
3. `interpolate` is a function that takes an object with keys `inputRange` and `outputRange`
4. create another variable for our styles and set `backgroundColor` to `interpolateColor`
5. change View to Animated.View and apply style
6. cDM Animated.timing, toValue is the upperlimit of the `inputRange`. choose a duration and call start()
