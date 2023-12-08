import 'package:web3modal_flutter/web3modal_flutter.dart';

Map<String, W3MNamespace> prepareRequiredNameSpace() {
  return {
    "eip155": const W3MNamespace(
        methods: ["personal_sign", "eth_sign", "eth_signTransaction"],
        events: [],
        chains: ["eip155:1", "eip155:421614"])
  };
}