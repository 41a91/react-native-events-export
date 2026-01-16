# react-native-events-export

A React Native module to allow users to export events to their iOS or Android calendars.

## Installation

```sh
npm install react-native-events-export
# or
yarn add react-native-events-export
```

### iOS

```sh
cd ios && pod install
```

> Requires **iOS 17+**

### Android

No additional steps required.

## Usage

```ts
import { addEventWithEditor } from 'react-native-events-export';

// ...

await addEventWithEditor(
  title: 'Test Event',
  startDate: Date.now(),
  endDate: Date.now() + 3600 * 1000,
  location: 'Test Location',
);
```

## Repeating Events (iOS only)

Recurring events are **only supported on iOS**.

Android intentionally does **not** support repeating events:

- The calendar editor 'Intent' ignores recurrence rules
- Supporting recurrence requires calendar permissions
- Behavior is inconsistent across OEM calendar apps

### Examples (iOS only)

## Monthly recurrence

```ts
await addEventWithEditor(
  title: 'Test monthly repeat event',
  startDate: Date.now(),
  endDate: Date.now() + 3600 * 1000,
  location: 'Test repeat location',
  repeatOptions: {
    frequency: 'monthly',
    interval: 1,
    unil: Date.now() + 1000 * 60 * 60 * 24 * 60 //2 months
  }
);
```

## Weekly on Mondays and Wednesdays
```ts
await addEventWithEditor(
  title: 'Test weekly repeat event',
  startDate: Date.now(),
  endDate: Date.now() + 3600 * 1000,
  location: 'Test weekly repeat location',
  repeatOptions: {
    frequency: 'weekly',
    interval: 1,
    until: Date.now() + 1000 * 60 * 60 * 24 * 30, //30 days
    daysOfWeek: [2, 4]
  }
);
```

### Important behavior: `daysOfWeek` overrides `frequency`
When **`daysOfWeek` is provided**, the event will repeat **only on those weekdays**

In this case:

* The `frequency` value is **ignored**
* The recurrence is treated as **weekly**
* The calendar determines occurrences strictly from `daysOfWeek`

---

## API

### `addEventWithEditor(options)`

#### Parameters

| Name            | Type     | Platform      | Required | Description                           |
| --------------- | -------- | ------------- | -------- | ------------------------------------- |
| `title`         | `string` | iOS / Android | ✅       | Event title                           |
| `startDate`     | `number` | iOS / Android | ✅       | Start time (milliseconds since epoch) |
| `endDate`       | `number` | iOS / Android | ✅       | End time (milliseconds since epoch)   |
| `location`      | `string` | iOS / Android | ❌       | Event location                        |
| `repeatOptions` | `object` | **iOS only**  | ❌       | See repeatOptions Type below          |

---

```ts
repeatOptions?: {
  frequency: 'daily' | 'weekly' | 'monthly' | 'yearly';
  interval?: number; //defaults to 1
  until?: number; //milliseconds since epoch
  daysOfWeek?: number[]; //1 = Sunday ... 7 = Saturday
}
```

#### Returns

```ts
Promise<void>;
```

Resolves when the editor is dismissed.

---

## Contributing

- [Development workflow](CONTRIBUTING.md#development-workflow)
- [Sending a pull request](CONTRIBUTING.md#sending-a-pull-request)

## License

MIT

---

Made with [create-react-native-library](https://github.com/callstack/react-native-builder-bob)
