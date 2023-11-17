export const getFormattedId = (input: string) => {
  const regExp = /[^0-9a-z]/;
  if (!regExp.test(input)) return;
  return input && input.replace(regExp, '');
};

export const getFormattedPrice = (input: string): string => {
  const numericValue = Number(input.replace(/\D/g, ''));
  const formattedPrice = numericValue.toLocaleString();
  return formattedPrice;
};

export const getNumericPrice = (input: string | number): number => {
  if (typeof input === 'number') return input;
  const numericValue = Number(input.replace(/\D/g, ''));
  return numericValue;
};
