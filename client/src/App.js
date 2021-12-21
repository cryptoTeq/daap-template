import React, { useEffect, useState } from "react";
import SimpleStorageContract from "./contracts/SimpleStorage.json";
import useWeb3 from "./hooks/useWeb3";

const App = () => {
  const [value, setValue] = useState(0);
  const [storageCntr, setStorageCntr] = useState(null);
  const [reload, setReload] = useState(true);
  const { web3, accounts, networkId } = useWeb3();
  const [cData, setCData] = useState(null);

  useEffect(() => {
    if (!web3) return;
    const load = async () => {
      const deployedNetwork = SimpleStorageContract.networks[networkId];
      const instance = new web3.eth.Contract(
        SimpleStorageContract.abi,
        deployedNetwork && deployedNetwork.address
      );
      setStorageCntr(instance);
    };
    load();
  }, [networkId, web3]);

  useEffect(() => {
    if (!storageCntr || !reload) return;

    const loadContractData = async () => {
      const data = await storageCntr.methods.get().call();
      setCData(data);
      setReload(false);
    };
    loadContractData();
  }, [storageCntr, reload]);

  const clickHandler = async () => {
    await storageCntr.methods.set(value).send({ from: accounts[0] });
    setReload(true);
  };

  return (
    <div>
      <input
        type="text"
        value={value}
        onChange={({ target: { value } }) => setValue(value)}
      />
      <button onClick={clickHandler}>Set</button>
      <h1>{cData}</h1>
    </div>
  );
};

export default App;
