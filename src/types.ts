export type RepeatFrequency = 'daily' | 'weekly' | 'monthly' | 'yearly';

export interface RepeatOptions {
  frequency: RepeatFrequency;
  interval: number;
  until: number;
};
