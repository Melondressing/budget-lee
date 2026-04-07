CREATE TABLE IF NOT EXISTS shared_budgets (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  description TEXT,
  owner_user_id INTEGER NOT NULL,
  invite_code TEXT UNIQUE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (owner_user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS shared_budget_members (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  shared_budget_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,
  role TEXT NOT NULL CHECK (role IN ('owner', 'editor', 'viewer')),
  joined_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (shared_budget_id) REFERENCES shared_budgets(id) ON DELETE CASCADE,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  UNIQUE(shared_budget_id, user_id)
);

CREATE TABLE IF NOT EXISTS shared_transactions (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  shared_budget_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,
  type TEXT NOT NULL CHECK (type IN ('income', 'expense', 'savings')),
  amount REAL NOT NULL,
  category TEXT NOT NULL,
  description TEXT,
  date TEXT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (shared_budget_id) REFERENCES shared_budgets(id) ON DELETE CASCADE,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS shared_wallets (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  description TEXT,
  total_savings REAL DEFAULT 0,
  total_expenses REAL DEFAULT 0,
  current_balance REAL DEFAULT 0,
  owner_user_id INTEGER NOT NULL,
  invite_code TEXT UNIQUE NOT NULL,
  is_active INTEGER DEFAULT 1,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (owner_user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS shared_wallet_members (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  shared_wallet_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,
  nickname TEXT,
  total_contributed REAL DEFAULT 0,
  total_spent REAL DEFAULT 0,
  joined_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (shared_wallet_id) REFERENCES shared_wallets(id) ON DELETE CASCADE,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  UNIQUE(shared_wallet_id, user_id)
);

CREATE TABLE IF NOT EXISTS shared_wallet_accounts (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  shared_wallet_id INTEGER NOT NULL,
  name TEXT NOT NULL,
  bank_name TEXT,
  account_number TEXT,
  balance REAL DEFAULT 0,
  description TEXT,
  icon TEXT DEFAULT '🏦',
  color TEXT DEFAULT '#3B82F6',
  is_active INTEGER DEFAULT 1,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  savings_goal REAL DEFAULT 0,
  FOREIGN KEY (shared_wallet_id) REFERENCES shared_wallets(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS shared_wallet_transactions (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  shared_wallet_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,
  type TEXT NOT NULL CHECK (type IN ('deposit', 'withdraw')),
  amount REAL NOT NULL CHECK (amount > 0),
  category TEXT,
  description TEXT,
  transaction_date TEXT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  account_id INTEGER REFERENCES shared_wallet_accounts(id) ON DELETE SET NULL,
  FOREIGN KEY (shared_wallet_id) REFERENCES shared_wallets(id) ON DELETE CASCADE,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS shared_wallet_budgets (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  shared_wallet_id INTEGER NOT NULL,
  category TEXT NOT NULL,
  monthly_limit REAL NOT NULL DEFAULT 0,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (shared_wallet_id) REFERENCES shared_wallets(id) ON DELETE CASCADE,
  UNIQUE(shared_wallet_id, category)
);

CREATE TABLE IF NOT EXISTS shared_account_transactions (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  account_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,
  type TEXT NOT NULL CHECK(type IN ('deposit', 'withdraw', 'transfer')),
  amount REAL NOT NULL,
  description TEXT,
  transaction_date DATE NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (account_id) REFERENCES shared_wallet_accounts(id) ON DELETE CASCADE,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_shared_budgets_owner_user_id
ON shared_budgets(owner_user_id);

CREATE INDEX IF NOT EXISTS idx_shared_budget_members_budget_id
ON shared_budget_members(shared_budget_id);

CREATE INDEX IF NOT EXISTS idx_shared_budget_members_user_id
ON shared_budget_members(user_id);

CREATE INDEX IF NOT EXISTS idx_shared_transactions_budget_id
ON shared_transactions(shared_budget_id);

CREATE INDEX IF NOT EXISTS idx_shared_transactions_user_id
ON shared_transactions(user_id);

CREATE INDEX IF NOT EXISTS idx_shared_transactions_date
ON shared_transactions(date);

CREATE INDEX IF NOT EXISTS idx_shared_wallets_owner_user_id
ON shared_wallets(owner_user_id);

CREATE INDEX IF NOT EXISTS idx_shared_wallet_members_wallet_id
ON shared_wallet_members(shared_wallet_id);

CREATE INDEX IF NOT EXISTS idx_shared_wallet_members_user_id
ON shared_wallet_members(user_id);

CREATE INDEX IF NOT EXISTS idx_shared_wallet_accounts_wallet_id
ON shared_wallet_accounts(shared_wallet_id);

CREATE INDEX IF NOT EXISTS idx_shared_wallet_transactions_wallet_id
ON shared_wallet_transactions(shared_wallet_id);

CREATE INDEX IF NOT EXISTS idx_shared_wallet_transactions_user_id
ON shared_wallet_transactions(user_id);

CREATE INDEX IF NOT EXISTS idx_shared_wallet_transactions_date
ON shared_wallet_transactions(transaction_date);

CREATE INDEX IF NOT EXISTS idx_shared_wallet_transactions_account_id
ON shared_wallet_transactions(account_id);

CREATE INDEX IF NOT EXISTS idx_shared_wallet_budgets_wallet_id
ON shared_wallet_budgets(shared_wallet_id);

CREATE INDEX IF NOT EXISTS idx_shared_account_transactions_account_id
ON shared_account_transactions(account_id);

CREATE INDEX IF NOT EXISTS idx_shared_account_transactions_user_id
ON shared_account_transactions(user_id);
