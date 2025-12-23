import { NativeModules } from "react-native";

const { EventsExportModule } = NativeModules;

const addEventWithEditor = async ({
  title,
  startDate,
  endDate,
  location,
}: {
  title: string;
  startDate: number;
  endDate: number;
  location?: string;
}) => {
  if (!EventsExportModule) {
    throw new Error("EventsExportModule native module is not linked");
  }

  return EventsExportModule.addEventWithEditor(
    title,
    startDate,
    endDate,
    location,
  );
};

export default {
  addEventWithEditor,
};
