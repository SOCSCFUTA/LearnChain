import { Route, Switch } from "wouter"
import { useState } from 'react'
import Home from './components/Home';
import { createNetworkConfig, SuiClientProvider, WalletProvider } from '@mysten/dapp-kit';
import { getFullnodeUrl } from '@mysten/sui/client';
import { QueryClient, QueryClientProvider } from '@tanstack/react-query';
import Login from "./components/Login";
import Signup from "./components/Signup";
import Notfound from  "./components/Notfound";
import RegisterEnokiWallets from "./components/RegisterWithEnoki";

// Config options for the networks you want to connect to
const { networkConfig } = createNetworkConfig({
  localnet: { url: getFullnodeUrl('localnet') },
  mainnet: { url: getFullnodeUrl('mainnet') },
  testnet: {
    url: getFullnodeUrl('testnet'),
    variables: {
      myMovePackageId: '',
    },
  }
});

const queryClient = new QueryClient();


export default function App() {
  const [activeNetwork, setActiveNetwork] = useState('testnet');

  return (
    <QueryClientProvider client={queryClient}>
      <SuiClientProvider
        onNetworkChange={(network) => {
          setActiveNetwork(network);
        }}
        networks={networkConfig}
        network='testnet'>
        <RegisterEnokiWallets />
        <WalletProvider autoconnect>
          <Routes />
          {
            activeNetwork
          }
        </WalletProvider>
      </SuiClientProvider>
    </QueryClientProvider>
  )
}

const Routes = () => {
  return (
    <div className="min-h-screen flex flex-col">
      <main className="flex-1">
        <Switch>
          <Route path="/" component={Home} />
          <Route path="/login" component={Login} />
          <Route path="/register" component={Signup} />
          <Route component={Notfound}/>
        </Switch>
      </main>
    </div>
  );
};