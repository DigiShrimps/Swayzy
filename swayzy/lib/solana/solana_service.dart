import 'dart:typed_data';
import 'package:bip39/bip39.dart' as bip39;
import 'package:solana/solana.dart';
import 'package:solana/encoder.dart';
import 'package:swayzy/constants/private_data.dart';

Future<void> passDataToContract(String senderWalletMnemonic, String recipientWalletMnemonic, double solAmount) async {
  final rpcUrl = 'https://api.devnet.solana.com';
  final websocketUrl = 'wss://api.devnet.solana.com';

  final client = SolanaClient(
    rpcUrl: Uri.parse(rpcUrl),
    websocketUrl: Uri.parse(websocketUrl),
  );

  final senderWallet = await Ed25519HDKeyPair.fromMnemonic(senderWalletMnemonic);

  final programId = Ed25519HDPublicKey.fromBase58(
    PrivateData.solanaProgramId,
  );

  final recipientWallet = await Ed25519HDKeyPair.fromMnemonic(recipientWalletMnemonic);

  final instructionCode = 1;
  int lamport = 1000000000;
  final amount = BigInt.from(solAmount * lamport); // 0.01 SOL
  final data = ByteArray(
    [instructionCode, ..._encodeAmount(amount)],
  );

  final message = Message(instructions: [
    Instruction(
      programId: programId,
      accounts: [
        AccountMeta.writeable(pubKey: senderWallet.publicKey, isSigner: true),
        AccountMeta.writeable(pubKey: recipientWallet.publicKey, isSigner: false),
        AccountMeta.readonly(pubKey: SystemProgram.id, isSigner: false),
      ],
      data: data,
    )
  ]);

  final tx = await client.sendAndConfirmTransaction(
    message: message,
    signers: [senderWallet],
    commitment: Commitment.confirmed,
  );
}

List<int> _encodeAmount(BigInt amount) {
  final buffer = ByteData(8);
  buffer.setUint64(0, amount.toInt(), Endian.little);
  return buffer.buffer.asUint8List();
}
