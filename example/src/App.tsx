import { View, StyleSheet, Button } from 'react-native';
import { addEventWithEditor } from 'react-native-events-export';

export default function App() {

  const addEvent = () => {
    try{
      addEventWithEditor("Test Event", Date.now(), Date.now() + 3600 * 1000, "Test Location");
    } catch {
      console.log("Something happened");
    }
  }

  return (
    <View style={styles.container}>
      <Button title={"Add Event"} onPress={() => {
        addEvent();
      }}/>
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
