import React from "react";
import getWeb3 from "../getWeb3";

const useWeb3 = () => {
  const [{ web3, accounts, networkId }, setContractInfo] = React.useState({
    web3: null,
    accounts: [],
    networkId: null,
  });

  React.useEffect(() => {
    const load = async () => {
      const web3 = await getWeb3();
      const accounts = await web3.eth.getAccounts();
      const networkId = await web3.eth.net.getId();
      setContractInfo({
        accounts,
        web3,
        networkId,
      });
    };
    load();
  }, []);

  return { web3, accounts, networkId };
};

export default useWeb3;
