import { TurboModuleRegistry, type TurboModule } from 'react-native';

export interface Spec extends TurboModule {
  addEventWithEditor(
    title: string,
    startDate: number,
    endDate: number,
    location?: string,
    repeatOptions?: {
      frequency: 'daily' | 'weekly' | 'monthly' | 'yearly';
      interval: number;
      until: number;
    }
  ): Promise<void>;
}

export default TurboModuleRegistry.getEnforcing<Spec>('EventsExport');
