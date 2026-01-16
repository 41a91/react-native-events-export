import { View, StyleSheet, Button } from 'react-native';
import { addEventWithEditor } from 'react-native-events-export';

export default function App() {
  const addEvent = () => {
    try {
      addEventWithEditor(
        'Test Event',
        Date.now(),
        Date.now() + 3600 * 1000,
        'Test Location'
      );
    } catch {
      console.log('Something happened');
    }
  };

  const addRepeatEvent = () => {
    try {
      addEventWithEditor(
        'Test Repeat Event',
        Date.now(),
        Date.now() + 3600 * 1000,
        'Test Location',
        {
          frequency: 'weekly',
          interval: 1,
          until: Date.now() + 3 * 7 * 24 * 60 * 60 * 1000,
        }
      );
    } catch {
      console.log('something happened');
    }
  };

  const addRepeatEventWithDays = () => {
    try {
      addEventWithEditor(
        'Test Repeat Weekly Event',
        Date.now(),
        Date.now() + 3600 * 1000,
        'Test Location',
        {
          frequency: 'weekly',
          interval: 1,
          until: Date.now() + 3 * 7 * 24 * 60 * 60 * 1000,
          daysOfWeek: [2,4,6]
        }
      );
    } catch {
      console.log('something happened');
    }
  };

  return (
    <View style={styles.container}>
      <Button
        title={'Add Event'}
        onPress={() => {
          addEvent();
        }}
      />
      <Button
        title={'Add Repeat Event'}
        onPress={() => {
          addRepeatEvent();
        }}
      />
      <Button 
        title={'Add Repeat Event With Days'}
        onPress={() => {
          addRepeatEventWithDays();
        }}
      />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
});
