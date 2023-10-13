import { lazy } from 'react';
import { createBrowserRouter } from 'react-router-dom';

import Layout from '@components/layout';
import Join from '@components/login/Join';
import OAuthCallback from '@components/login/OAuthCallback';
import NotFound from '@pages/NotFound';

const Home = lazy(() => import('@pages/Home'));
const Login = lazy(() => import('@pages/Login'));
const WishList = lazy(() => import('@pages/WishList'));
const SalesHistory = lazy(() => import('@pages/SalesHistory'));
const ChatPage = lazy(() => import('@pages/ChatPage'));

const router = createBrowserRouter([
  {
    path: '/',
    element: <Layout />,
    errorElement: <NotFound />,
    children: [
      {
        path: '',
        element: <Home />,
      },
      {
        path: 'login',
        element: <Login />,
      },
      {
        path: 'wish-list',
        element: <WishList />,
      },
      {
        path: 'sales-history',
        element: <SalesHistory />,
      },
      {
        path: 'chat-list/:itemId?',
        element: <ChatPage />,
      },
    ],
  },
  {
    path: 'login/oauth2/code/github',
    element: <OAuthCallback />,
  },
  {
    path: 'join',
    element: <Join />,
  },
]);

export default router;
