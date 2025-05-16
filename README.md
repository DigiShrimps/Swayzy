# 💜Swayzy💜
## Description
Swayzy is designed to reward users for promoting brands and products on social media 🌍. By sharing content and engaging with their audience, users can earn SOL and NFT 💰, creating a unique way to connect social influence with cryptocurrency. It's all about turning your digital presence into real value

🔴 Note: The application is still under development, some features may not be available or may not work correctly. The main application is currently running on devnet.

---

## 👉 Used technologies
- Programming language: Dart
- UI: Flutter
- Back-end: Firebase

---

## ⚙️ Requirements

To run the full system successfully, you need:

**📡 Firebase Connection**  
  The app relies on Firebase for authentication and database.  
  Make sure to:
- Set up a Firebase project
- Enable any necessary Firebase services (e.g., Firestore, Auth)

**🚀 Deploy the Solana Program**
  The Rust-based smart contract must be deployed to the Solana blockchain (e.g., devnet or mainnet).  
  Steps:
1. Build the smart contract using `cargo build-sbf`
2. Deploy it with Solana CLI:
   ```bash
   solana program deploy ./target/deploy/your_program.so
   ```
3. Use the returned program ID in your client code to interact with the deployed contract

---

## 📤 Deployed Rust program

This Rust-based Solana smart contract (on-chain program) defines a function process_instruction that performs a simple fund transfer:

- Accepts an instruction code and an amount in lamports (Solana's smallest unit).
- Validates that the instruction is authorized (only if the first byte equals 1).
- Transfers the specified amount of lamports from the payer to the recipient account.
- Ensures correct data length and secure use of the system program to perform the transfer.

```Rust
use solana_program::{
    account_info::{next_account_info, AccountInfo},
    entrypoint::ProgramResult,
    msg,
    program::{invoke},
    program_error::ProgramError,
    pubkey::Pubkey,
    system_instruction,
};

pub fn process_instruction(
    _program_id: &Pubkey,
    accounts: &[AccountInfo],
    instruction_data: &[u8],
) -> ProgramResult {
    let instruction_code = instruction_data[0];
    if instruction_code != 1 {
        msg!("Transaction not approved");
        return Err(ProgramError::InvalidInstructionData);
    }

    if instruction_data.len() != 9 {
        msg!("Invalid data length");
        return Err(ProgramError::InvalidInstructionData);
    }

    let amount = u64::from_le_bytes(instruction_data[1..9].try_into().unwrap());

    let account_info_iter = &mut accounts.iter();
    let payer = next_account_info(account_info_iter)?;
    let recipient = next_account_info(account_info_iter)?;
    let system_program = next_account_info(account_info_iter)?;

    msg!("Transferring {} lamports", amount);

    let transfer_ix = system_instruction::transfer(
        payer.key,
        recipient.key,
        amount,
    );

    invoke(
        &transfer_ix,
        &[
            payer.clone(),
            recipient.clone(),
            system_program.clone(),
        ],
    )?;

    Ok(())
}

```
