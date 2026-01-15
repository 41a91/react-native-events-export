import { Platform } from 'react-native';
import EventsExport from './NativeEventsExport';
import type { RepeatOptions } from './types';


export function addEventWithEditor(
  title: string,
  startDate: number,
  endDate: number,
  location?: string,
  repeatOptions?: RepeatOptions
): Promise<void> {
  
  return EventsExport.addEventWithEditor(
      title,
      startDate,
      endDate,
      location,
      Platform.OS ? repeatOptions ?? null : null
    );
  
}
