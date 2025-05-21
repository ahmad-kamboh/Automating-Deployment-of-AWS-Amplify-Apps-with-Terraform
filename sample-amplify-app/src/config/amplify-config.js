import { Amplify } from 'aws-amplify';

const AmplifyConfig = {
  API: {
    GraphQL: {
      endpoint: `${import.meta.env.VITE_GRAPHQL_URL}`,
      region: `${import.meta.env.VITE_REGION}`,
      defaultAuthMode: 'userPool',
    },
  },
  Auth: {
    Cognito: {
      userPoolClientId: import.meta.env.VITE_APP_CLIENT_ID,
      userPoolId: `${import.meta.env.VITE_USER_POOL_ID}`,
      region: `${import.meta.env.VITE_REGION}`,
      identityPoolId: import.meta.env.VITE_IDENTITY_POOL_ID,
    },
  },
};

Amplify.configure(AmplifyConfig);

export default AmplifyConfig;
