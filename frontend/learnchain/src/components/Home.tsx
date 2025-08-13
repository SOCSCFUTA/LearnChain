
import React from "react";
import { ConnectButton, useCurrentAccount } from "@mysten/dapp-kit";
import Balances from "./Balances";

const OrganizationHome = () => {
  const currentAccount = useCurrentAccount();

  return (
    <div className="min-h-screen flex flex-col bg-gray-50">
      {/* Header */}
      <header className="w-full flex justify-between items-center p-4 bg-white shadow-md">
        <h1 className="text-2xl font-bold text-gray-800">CertiChain</h1>
        <ConnectButton />
        <span>{currentAccount?.address}</span>
      </header>

      {/* Main Content */}
      <main className="flex-1 p-6">
        <h2 className="text-xl font-semibold text-gray-700 mb-6">
          Organization Dashboard
        </h2>

        {/* Balance Component */}
        {currentAccount ? (
          <div className="bg-white rounded-lg shadow-md p-4">
            <Balances clientAddress={currentAccount.address}/>
          </div>
        ) : (
          <div className="bg-white rounded-lg shadow-md p-4 text-gray-600">
            Connect your wallet to continue!
          </div>
        )}
      </main>
    </div>
  );
};

export default OrganizationHome;
