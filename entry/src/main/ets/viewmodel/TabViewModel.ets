

import { TabItem } from './TabItem';

export function initTabData(): TabItem[] {
  let tabDataArray: TabItem[] = [];
  TabItemData.forEach((item: TabItem) => {
    tabDataArray.push(new TabItem(item.id, item.name));
  })
  return tabDataArray;
}



const TabItemData: TabItem[] = [
  new TabItem(0, 'Clock'),
  new TabItem(1, 'Mood'),
  new TabItem(2, 'Pomodoro')
];

