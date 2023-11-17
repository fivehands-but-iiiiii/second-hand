import { createGlobalStyle } from 'styled-components';
import { normalize } from 'styled-normalize';

const GlobalStyle = createGlobalStyle`
  ${normalize}

  html,
  body {
    background-color: #fef3d6;
  }

  * {
    box-sizing: border-box;
  }

  button {
    border: none;
    cursor: pointer;
    background-color: transparent;
    line-height: normal;
  }

  a {
    text-decoration: none;
    color: inherit;
  }

  ul,li, ol {
    list-style: none;
    margin: 0;
    padding: 0;
  }

  main {
    position: relative;
    max-width: 420px;
    height: 100vh;
    background-color: white;
  }

  @media only screen and (max-width: 768px) {
    main {
      margin: 0 auto;
    }
  }

  @media screen and (min-width: 768px) and (max-width: 1024px) {
    main {
      margin: 0 auto;
      min-width: 375px;
    }
  }

  @media only screen and (min-width: 1025px) {
    body {
      background-image: url(/images/second-hand-background.png);
      background-repeat: no-repeat;
      background-size: cover;
      background-position: center;
    }
    main {
      left: 50vw;
    }
  }
`;

export default GlobalStyle;
