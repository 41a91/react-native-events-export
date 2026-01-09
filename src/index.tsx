import EventsExport from './NativeEventsExport';

export function addEventWithEditor(
  title: string,
  startDate: number,
  endDate: number,
  location?: string
): Promise<void> {
  return EventsExport.addEventWithEditor(title, startDate, endDate, location);
}
