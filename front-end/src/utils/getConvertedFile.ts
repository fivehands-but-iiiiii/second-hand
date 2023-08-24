// TODO: utils > convertFile.ts랑 똑같은 로직인데, 하나는 삭제하기
export const getPreviewURL = async (file: File): Promise<string> => {
  const reader = new FileReader();
  reader.readAsDataURL(file);
  return new Promise((resolve) => {
    reader.onloadend = () => {
      resolve(reader.result as string);
    };
  });
};
