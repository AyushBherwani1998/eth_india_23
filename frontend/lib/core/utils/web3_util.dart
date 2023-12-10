import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/core/app_config.dart';
import 'package:frontend/core/curve_grid/curve_grid_provider.dart';
import 'package:frontend/core/service_locator.dart';
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

Future<String> safeMint(String lable, String contractType,
    [bool isPoap = false]) async {
  final curveGrid = ServiceLocator.getIt<CurveGridProvider>();
  final response = await curveGrid.callContractWriteFunction(
    contractLabel: lable,
    contractType: contractType,
    methodName: "safeMint",
    from: "0x6d66b909636b4f0C179cb50a3710B3ab614dD67a",
    signer: "0x6d66b909636b4f0C179cb50a3710B3ab614dD67a",
    args: [
      AppConfig.userAddress(),
    ],
    signAndSubmit: true,
  );

   return response.result.tx.hash;

  // if (!isPoap) {
  //   return response.result.tx.hash;
  // }

  // final registryResponse = await curveGrid.callContractWriteFunction(
  //   contractLabel: "account",
  //   contractType: "account",
  //   methodName: "createAccount",
  //   from: "0x6d66b909636b4f0C179cb50a3710B3ab614dD67a",
  //   signer: "0x6d66b909636b4f0C179cb50a3710B3ab614dD67a",
  //   args: [
  //     "0xb46234154B9848Fc49E0D0B57245BF927631000C",
  //   ],
  //   signAndSubmit: true,
  // );
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
