import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:web3dart/web3dart.dart';

Future<bool> createTokenBoundAccount() async {
  try {
    final DeployedContract accountContract = await perepareContract(
      address: dotenv.env["ACCOUNT_ADDRESS"] as String,
      contractName: "ERC6551Account",
      fileName: 'account',
    );

    final DeployedContract registryContract = await perepareContract(
      fileName: 'registry',
      contractName: "ERC6551Registry",
      address: dotenv.env["REGISTRY_ADDRESS"] as String,
    );
    return true;
  } catch (e, _) {
    return false;
  }
}

Future<DeployedContract> perepareContract({
  required String fileName,
  required String contractName,
  required String address,
}) async {
  final abi = await _prepareContractAbi(contractName, fileName);
  final contract = DeployedContract(abi, EthereumAddress.fromHex(address));
  return contract;
}

Future<ContractAbi> _prepareContractAbi(String name, String fileName) async {
  final file = File('assets/$fileName.json');
  final abi = await file.readAsString();

  return ContractAbi.fromJson(abi, name);
}
