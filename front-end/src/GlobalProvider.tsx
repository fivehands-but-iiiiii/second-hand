import { ReactNode } from 'react';

import ResponsiveLayout from '@components/layout/ResponsiveLayout';
import GlobalStyle from '@styles/globalStyles';
import theme from '@styles/theme';

import { ThemeProvider } from 'styled-components';

interface GlobalProviderProps {
  children: ReactNode;
}

const GlobalProvider = ({ children }: GlobalProviderProps) => (
  <ThemeProvider theme={theme}>
    <ResponsiveLayout>
      <GlobalStyle />
      {children}
    </ResponsiveLayout>
  </ThemeProvider>
);

export default GlobalProvider;
