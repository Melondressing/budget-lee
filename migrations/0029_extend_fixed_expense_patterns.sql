PRAGMA foreign_keys=OFF;

CREATE TABLE fixed_expenses_new (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  category TEXT NOT NULL,
  amount INTEGER NOT NULL,
  frequency TEXT NOT NULL CHECK(frequency IN ('daily', 'weekly', 'monthly', 'monthly_day', 'yearly')),
  week_of_month INTEGER CHECK(week_of_month BETWEEN 1 AND 5),
  day_of_week INTEGER CHECK(day_of_week BETWEEN 0 AND 6),
  payment_day INTEGER CHECK(payment_day BETWEEN 1 AND 31),
  month_of_year INTEGER CHECK(month_of_year BETWEEN 1 AND 12),
  is_active INTEGER DEFAULT 1,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  user_id TEXT
);

INSERT INTO fixed_expenses_new (
  id,
  name,
  category,
  amount,
  frequency,
  week_of_month,
  day_of_week,
  payment_day,
  month_of_year,
  is_active,
  created_at,
  user_id
)
SELECT
  id,
  name,
  category,
  amount,
  CASE
    WHEN frequency IN ('daily', 'weekly', 'monthly', 'monthly_day', 'yearly') THEN frequency
    ELSE 'monthly_day'
  END,
  week_of_month,
  day_of_week,
  payment_day,
  NULL,
  is_active,
  created_at,
  user_id
FROM fixed_expenses;

DROP TABLE fixed_expenses;
ALTER TABLE fixed_expenses_new RENAME TO fixed_expenses;

CREATE INDEX IF NOT EXISTS idx_fixed_expenses_user_id ON fixed_expenses(user_id);

CREATE TABLE fixed_expense_payments_new (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  fixed_expense_id INTEGER NOT NULL,
  transaction_id INTEGER,
  payment_date DATE NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  user_id TEXT,
  FOREIGN KEY (fixed_expense_id) REFERENCES fixed_expenses(id) ON DELETE CASCADE,
  FOREIGN KEY (transaction_id) REFERENCES transactions(id) ON DELETE CASCADE
);

INSERT INTO fixed_expense_payments_new (
  id,
  fixed_expense_id,
  transaction_id,
  payment_date,
  created_at,
  user_id
)
SELECT
  id,
  fixed_expense_id,
  transaction_id,
  payment_date,
  created_at,
  user_id
FROM fixed_expense_payments;

DROP TABLE fixed_expense_payments;
ALTER TABLE fixed_expense_payments_new RENAME TO fixed_expense_payments;

CREATE INDEX IF NOT EXISTS idx_fixed_expense_payments_date
ON fixed_expense_payments(fixed_expense_id, payment_date);

CREATE INDEX IF NOT EXISTS idx_fixed_expense_payments_user_id
ON fixed_expense_payments(user_id);

PRAGMA foreign_keys=ON;
