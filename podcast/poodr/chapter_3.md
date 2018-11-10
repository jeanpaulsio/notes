# Chapter 3 - Managing Dependencies

* objects must collaborate to accomplish tasks
* a class should know just enough to do its job

```
class Gear
  attr_reader :chainring, :cog, :rim, :tire

  def initialize(chainring, cog, rim, tire)
    @chainring = chainring
    @cog       = cog
    @rim       = rim
    @tire      = tire
  end

  def gear_inches
    ratio * Wheel.new(rim, tire).diameter
  end

  # ...
end

Gear.new(52, 11, 26, 1.5).gear_inches
```

---

## Picks

JP:https://mtlynch.io/good-developers-bad-tests/
