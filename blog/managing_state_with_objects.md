When we fetch a list of dogpack members from the API, we get a response in the form of an array, like this:

```json
[
  {
    "id": 3,
    "name": "Jim",
    "email": "jim@test.com",
    "phone": "9095551234",
    "twitter_handle": "jimhalpert",
    "user_id": 1
  },
  {
    "id": 5,
    "name": "Pam",
    "email": "pam@test.com",
    "phone": "9095551234",
    "twitter_handle": "pambeasley",
    "user_id": 1
  }
]
```

And this is nice and all, but we can do better. ideally, it would be nice if we could massage the data to look like this

```json
{
  "3": {
    "id": 3,
    "name": "Jim",
    "email": "jim@test.com",
    "phone": "9095551234",
    "twitter_handle": "jimhalpert",
    "user_id": 1
  },
  "5": {
    "id": 5,
    "name": "Pam",
    "email": "pam@test.com",
    "phone": "9095551234",
    "twitter_handle": "pambeasley",
    "user_id": 1
  }
}
```

Instead of using an array, we have an object!!!

___________

Right now, our reducer is returning back the array of objects:

`return { ...state, recipients_index: action.payload };`

But how can we make it return an object instead? Enter *lodash*!

`return _.mapKeys(action.payload, 'id')`

now when we map state to props, we'll be mapping an OBJECT instead of an array. in order for us to iterate each item, we have to use lodash again (since the built in map function can't map over an object)

previously, my mapStateToProps:

```js
const mapStateToProps = state => {
  return {
    tokens: state.devise.tokens,
    recipients: state.recipients.recipients_index
  };
}
```

now...

```js
const mapStateToProps = state => {
  return {
    tokens: state.devise.tokens,
    recipients: state.recipients
  };
}
```

SHOWING:

before:
`return { ...state, recipient_show: action.payload };`

after:
`return { ...state, [action.payload.id]: action.payload }`

the problem is that before, when i was mapping my state to props, i would return something like this:

`recipient_show: state.recipients.recipient_show`

then, i would call `this.props.recipient_show` and my state would look like this

recipients: `recipient_index: [{ recipient }, { recipient }], recipient_show: {}`


but NOW, the code is much more elegant. i only have one recipient object

i can `SHOW` by returning in my MSTP:

```js
const mapStateToProps = (state) => {
  return {
    recipient: state.recipients[state.recipients.recipient_id],
    recipient_id: state.recipients.recipient_id,
    tokens: state.devise.tokens,
    // recipient_show: state.recipients.recipient_show
  };
};
```


## where it really matters

lets see how complex this ends up being when we use arrays

```javascript
case PATCH_RECIPIENT_UPDATE:
  return {
    ...state,
    recipient_show: action.payload,
    recipients_index: state.recipients_index.map(recipient => {
      if (recipient['id'] === action.payload['id']) {
        return action.payload;
      }
      return recipient;
    })
  };
```
What are we doing here? Because we are using an array, we have to iterate through it and find the recipient id. IF the recipient ID matches, we update the payload. ELSE do nothing. map follows the rules of redux and returns an new object instead of mutating it. but look how NASTY this is. check out what we can do if we use an object instead:

```javascript
return { ...state, [action.payload.id]: action.payload }
```

literally one line. mind blowing!

## what about deleting a record?

currently my action.payload is just an `id` but look at what we have to do - we have  ITERATE through the array like so:

```javascript
return {
  ...state,
  recipients_index: state.recipients_index.filter(recipient => {
    return recipient['id'] !== action.payload;
  })
}
```
... but if we use objects, lodash to the rescue:

```javascript
return _.omit(state, action.payload)
```


and i thought i was being clever with how i handled it with the filter method!

## Posting a record


