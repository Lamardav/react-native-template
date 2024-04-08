import React from "react";
import {Action, configureStore, ThunkAction} from "@reduxjs/toolkit";
import {PersistConfig, persistReducer, persistStore} from "redux-persist";
import {rootReducer, RootState} from "./rootReducer";
import {Provider, TypedUseSelectorHook, useDispatch, useSelector} from "react-redux";
import {PersistGate} from "redux-persist/integration/react";
import AsyncStorage from "@react-native-async-storage/async-storage";
import {setLanguage} from "~/common/localization/localization";

const persistConfig: PersistConfig<RootState> = {
  key: "root",
  storage: AsyncStorage,
  version: 1,
  timeout: 1000,
};

// const options: ReduxLoggerOptions = {
//   diff: true,
//   collapsed: true,
//   predicate: (): boolean => {
//     return __DEV__;
//   },
// };

const persistedReducer = persistReducer(persistConfig, rootReducer);

// const logger = createLogger(options);

export const store = configureStore({
  reducer: persistedReducer,
  // middleware: () => new Tuple(additionalMiddleware, logger),
});

export const persistor = persistStore(store, undefined, async () => {
  const state: RootState = store.getState();
  await setLanguage(state.system.language);
});

type AppDispatch = typeof store.dispatch;
export type AppThunk = ThunkAction<void, RootState, unknown, Action<string>>;
export const useAppDispatch = () => useDispatch<AppDispatch>();
export const useAppSelector: TypedUseSelectorHook<RootState> = useSelector;

export const reduxProvider = (Component: any) => (props: any) => {
  return (
    <Provider store={store}>
      <PersistGate loading={null} persistor={persistor} onBeforeLift={setLanguage}>
        <Component {...props} />
      </PersistGate>
    </Provider>
  );
};
