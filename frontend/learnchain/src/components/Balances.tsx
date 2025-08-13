import React from 'react';
import { useSuiClientQuery } from '@mysten/dapp-kit';

const Balances = ({clientAddress}) => {
  const { data, isPending, isError, error } = useSuiClientQuery(
    'getAllBalances',
    { owner: clientAddress }, // Replace with actual connected wallet address
    {
      gcTime: 10000,
    }
  );

  if (isPending) {
    return (
      <div className="flex items-center justify-center min-h-screen bg-gray-50">
        <div className="text-gray-600 text-lg">Loading balance...</div>
      </div>
    );
  }

  if (isError) {
    return (
      <div className="flex items-center justify-center min-h-screen bg-red-50">
        <div className="text-red-600 text-lg">Error: {error.message}</div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gray-50 py-10 px-4">
      <div className="max-w-2xl mx-auto bg-white shadow-md rounded-lg p-6">
        <h1 className="text-2xl font-bold text-gray-800 mb-4">Your Balances</h1>
        {data?.length > 0 ? (
          <ul className="space-y-3">
            {data.map((balance, idx) => (
              <li
                key={idx}
                className="flex items-center justify-between bg-gray-100 rounded-md px-4 py-2 hover:bg-gray-200"
              >
                <span className="font-medium text-gray-700">
                  {balance.coinType.split('::').pop()}
                </span>
                <span className="text-gray-900 font-semibold">
                  {balance.totalBalance}
                </span>
              </li>
            ))}
          </ul>
        ) : (
          <p className="text-gray-500">No balances found.</p>
        )}
      </div>
    </div>
  );
};

export default Balances;
