interface sessionStorageProps {
  key: string;
  value?: object;
}

export const getStoredValue = ({ key }: sessionStorageProps) => {
  try {
    const value = sessionStorage.getItem(key);
    return value ? JSON.parse(value) : null;
  } catch (err) {
    console.error('Error getting sessionStorage:', err);
  }
};

export const setStorageValue = ({ key, value }: sessionStorageProps) => {
  try {
    sessionStorage.setItem(key, JSON.stringify(value));
  } catch (err) {
    console.error('Error setting sessionStorage:', err);
  }
};

export const removeStorageValue = (...keys: sessionStorageProps['key'][]) => {
  try {
    keys.forEach((key) => {
      sessionStorage.removeItem(key);
    });
  } catch (err) {
    console.error('Error removing sessionStorage:', err);
  }
};
