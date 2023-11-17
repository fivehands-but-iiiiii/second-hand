import { RouterProvider } from 'react-router-dom';

import router from '@routes/router';
import GlobalStyle from '@styles/globalStyles';
import theme from '@styles/theme';

import { ThemeProvider } from 'styled-components';
import ResponsiveLayout from '@components/layout/ResponsiveLayout';

const App = () => {
  return (
    <ThemeProvider theme={theme}>
      <ResponsiveLayout>
        <GlobalStyle />
        <RouterProvider router={router} />
      </ResponsiveLayout>
    </ThemeProvider>
  );
};

export default App;
