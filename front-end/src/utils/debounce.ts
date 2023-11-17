interface DebounceTypes<T extends any[]> {
  (callback: (...args: T) => void, delay: number): (...args: T) => void;
}

export const debounce: DebounceTypes<any[]> = (callback, delay) => {
  let timer: ReturnType<typeof setTimeout>;
  return (...args) => {
    clearTimeout(timer);
    timer = setTimeout(() => callback(...args), delay);
  };
};
