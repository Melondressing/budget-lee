CREATE TABLE IF NOT EXISTS custom_categories (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER NOT NULL,
  name TEXT NOT NULL,
  type TEXT NOT NULL CHECK (type IN ('expense', 'income', 'savings')),
  color TEXT DEFAULT '#3B82F6',
  icon TEXT DEFAULT '💰',
  budget_amount REAL DEFAULT 0,
  is_active INTEGER DEFAULT 1,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_custom_categories_user_id
ON custom_categories(user_id);

CREATE INDEX IF NOT EXISTS idx_custom_categories_user_type_active
ON custom_categories(user_id, type, is_active);
