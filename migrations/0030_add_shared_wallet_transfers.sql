CREATE TABLE IF NOT EXISTS shared_wallet_transfers (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  shared_wallet_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,
  from_account_id INTEGER NOT NULL,
  to_account_id INTEGER NOT NULL,
  amount REAL NOT NULL,
  description TEXT,
  transfer_date DATE NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (shared_wallet_id) REFERENCES shared_wallets(id) ON DELETE CASCADE,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (from_account_id) REFERENCES shared_wallet_accounts(id) ON DELETE CASCADE,
  FOREIGN KEY (to_account_id) REFERENCES shared_wallet_accounts(id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_shared_wallet_transfers_wallet_id
ON shared_wallet_transfers(shared_wallet_id);

CREATE INDEX IF NOT EXISTS idx_shared_wallet_transfers_user_id
ON shared_wallet_transfers(user_id);

CREATE INDEX IF NOT EXISTS idx_shared_wallet_transfers_date
ON shared_wallet_transfers(transfer_date);
