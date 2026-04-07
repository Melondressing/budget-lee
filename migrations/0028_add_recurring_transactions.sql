CREATE TABLE IF NOT EXISTS recurring_transactions (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER NOT NULL,
  type TEXT NOT NULL CHECK (type IN ('income', 'expense', 'savings')),
  amount REAL NOT NULL,
  category TEXT NOT NULL,
  description TEXT NOT NULL,
  recurrence_type TEXT NOT NULL CHECK (recurrence_type IN ('daily', 'weekly', 'monthly', 'yearly')),
  recurrence_day INTEGER,
  recurrence_month INTEGER,
  start_date TEXT NOT NULL,
  end_date TEXT,
  next_due_date TEXT NOT NULL,
  is_active INTEGER DEFAULT 1,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS recurring_transaction_instances (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  recurring_transaction_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,
  due_date TEXT NOT NULL,
  status TEXT NOT NULL DEFAULT 'scheduled' CHECK (status IN ('scheduled', 'pending', 'completed', 'skipped')),
  transaction_id INTEGER,
  completed_at DATETIME,
  skipped_reason TEXT,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (recurring_transaction_id) REFERENCES recurring_transactions(id) ON DELETE CASCADE,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (transaction_id) REFERENCES transactions(id) ON DELETE SET NULL,
  UNIQUE(recurring_transaction_id, due_date)
);

CREATE INDEX IF NOT EXISTS idx_recurring_transactions_user_id
ON recurring_transactions(user_id);

CREATE INDEX IF NOT EXISTS idx_recurring_transactions_next_due_date
ON recurring_transactions(next_due_date);

CREATE INDEX IF NOT EXISTS idx_recurring_transaction_instances_recurring_id
ON recurring_transaction_instances(recurring_transaction_id);

CREATE INDEX IF NOT EXISTS idx_recurring_transaction_instances_due_date
ON recurring_transaction_instances(due_date);

CREATE INDEX IF NOT EXISTS idx_recurring_transaction_instances_status
ON recurring_transaction_instances(status);
