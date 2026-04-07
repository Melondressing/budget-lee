CREATE TABLE IF NOT EXISTS monthly_reports (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER NOT NULL,
  year_month TEXT NOT NULL,
  total_income REAL DEFAULT 0,
  total_expense REAL DEFAULT 0,
  total_savings REAL DEFAULT 0,
  net_balance REAL DEFAULT 0,
  category_breakdown TEXT,
  income_change_pct REAL DEFAULT 0,
  expense_change_pct REAL DEFAULT 0,
  top_categories TEXT,
  ai_insights TEXT,
  transaction_count INTEGER DEFAULT 0,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  UNIQUE(user_id, year_month)
);

CREATE INDEX IF NOT EXISTS idx_monthly_reports_user_id
ON monthly_reports(user_id);

CREATE INDEX IF NOT EXISTS idx_monthly_reports_year_month
ON monthly_reports(year_month);
