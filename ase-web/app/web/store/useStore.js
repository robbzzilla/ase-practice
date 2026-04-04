import { create } from 'zustand';

const useStore = create((set) => ({
  // 1. Define your global state variables
  isDarkMode: false,
  globalMode: 'practice', // 'practice' or 'exam'
  
  // 2. Define functions to change those variables
  toggleDarkMode: () => set((state) => ({ isDarkMode: !state.isDarkMode })),
  setGlobalMode: (mode) => set({ globalMode: mode }),
}));

export default useStore;