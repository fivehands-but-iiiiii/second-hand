import React from 'react';
import { RouterProvider } from 'react-router-dom';

import router from '@routes/router';
import ReactDOM from 'react-dom/client';

import GlobalProvider from './GlobalProvider';

ReactDOM.createRoot(document.getElementById('root') as HTMLElement).render(
  <React.StrictMode>
    <GlobalProvider>
      <RouterProvider router={router} />
    </GlobalProvider>
  </React.StrictMode>,
);
