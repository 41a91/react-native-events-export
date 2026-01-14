# react-native-events-export

A React Native module to allow users to export events to their iOS or Android calendars.

## Installation

```sh
npm install react-native-events-export
# or
yarn add react-native-events-export
```

## Usage

```ts
import { addEventWithEditor } from 'react-native-events-export';

// ...

await addEventWithEditor({
  title: 'Test Event',
  startDate: Date.now(),
  endDate: Date.now() + 3600 * 1000,
  location: 'Test Location',
});
```

## API

### `addEventWithEditor(options)`

#### Parameters

| Name        | Type     | Required | Description                           |
| ----------- | -------- | -------- | ------------------------------------- |
| `title`     | `string` | ✅       | Event title                           |
| `startDate` | `number` | ✅       | Start time (milliseconds since epoch) |
| `endDate`   | `number` | ✅       | End time (milliseconds since epoch)   |
| `location`  | `string` | ❌       | Event location                        |

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
