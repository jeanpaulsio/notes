const log = (...args) => console.log(...args);
const trace = label => value => {
  log(`${label}: ${value}`);
  return value;
};

const addThree = x => 3 + x;
const double = x => 2 * x;

const compose = (...fns) => initial => {
  return fns.reduceRight((acc, fn) => {
    acc = fn(acc);

    return acc;
  }, initial);
};

const traceInitial = trace("initial");
const traceDouble = trace("double");

compose(
  trace("addThree"),
  addThree,
  traceDouble,
  double,
  traceDouble,
  double,
  traceInitial
)(4);
