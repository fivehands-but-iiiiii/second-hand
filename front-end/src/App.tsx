import { RouterProvider } from 'react-router-dom';

import ResponsiveLayout from '@components/layout/ResponsiveLayout';
import router from '@routes/router';
import GlobalStyle from '@styles/globalStyles';
import theme from '@styles/theme';

import { ThemeProvider } from 'styled-components';

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
