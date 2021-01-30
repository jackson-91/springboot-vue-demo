import Vue from 'vue'
import { store } from '../../store/store'
export default (dicItemValue, dicCode) => {
    let dic = store.state.dicset;
    let label = dicCode;
    if (dic && dic.length > 0) {
        dic.forEach(element => {
            if (element.dicCode === dicCode) {
                let sysDicItems = element.sysDicItems;
                if (sysDicItems && sysDicItems.length > 0) {
                    sysDicItems.forEach(item => {
                        if (item.dicItemValue == dicItemValue) {
                            label = item.dicItemName;
                            return;
                        }
                    });
                }
            }
        });
    }
    return label;
};