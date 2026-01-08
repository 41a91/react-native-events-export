import { TurboModuleRegistry, type TurboModule } from 'react-native';

export interface Spec extends TurboModule {
  addEventWithEditor(
    title: string,
    startDate: number,
    endDate: number,
    location?: string
  ): Promise<void>;
}

export default TurboModuleRegistry.getEnforcing<Spec>('EventsExport');
