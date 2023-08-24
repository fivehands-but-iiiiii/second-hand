interface sessionStorageProps {
  key: string;
  value?: object;
}

const getStoredValue = ({ key }: sessionStorageProps) => {
  try {
    const value = sessionStorage.getItem(key);
    return value ? JSON.parse(value) : null;
  } catch (err) {
    console.error('Error getting sessionStorage:', err);
  }
};

const setStorageValue = ({ key, value }: sessionStorageProps) => {
  try {
    sessionStorage.setItem(key, JSON.stringify(value));
  } catch (err) {
    console.error('Error setting sessionStorage:', err);
  }
};

const removeStorageValue = (...keys: sessionStorageProps['key'][]) => {
  try {
    keys.forEach((key) => {
      sessionStorage.removeItem(key);
    });
  } catch (err) {
    console.error('Error removing sessionStorage:', err);
  }
};

// TODO: formatText.ts 처럼 함수 앞에 export를 각자 붙일 건지 현 파일처럼 할 건지 정하기
export { getStoredValue, setStorageValue, removeStorageValue };
