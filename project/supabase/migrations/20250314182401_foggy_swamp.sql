/*
  # Initial Schema Setup for Betting Platform

  1. New Tables
    - `profiles`
      - `id` (uuid, primary key, references auth.users)
      - `username` (text)
      - `balance` (decimal)
      - `created_at` (timestamp)
    - `bets`
      - `id` (uuid, primary key)
      - `user_id` (uuid, references profiles)
      - `event` (text)
      - `amount` (decimal)
      - `odds` (decimal)
      - `status` (text)
      - `created_at` (timestamp)
    - `transactions`
      - `id` (uuid, primary key)
      - `user_id` (uuid, references profiles)
      - `amount` (decimal)
      - `type` (text)
      - `created_at` (timestamp)

  2. Security
    - Enable RLS on all tables
    - Add policies for authenticated users to:
      - Read and update their own profile
      - Create and read their own bets
      - Create and read their own transactions
*/

-- Safe creation of profiles table
CREATE TABLE IF NOT EXISTS profiles (
  id uuid PRIMARY KEY REFERENCES auth.users,
  username text UNIQUE,
  balance decimal DEFAULT 0.00,
  created_at timestamptz DEFAULT now()
);

-- Safe creation of bets table
CREATE TABLE IF NOT EXISTS bets (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid REFERENCES profiles,
  event text NOT NULL,
  amount decimal NOT NULL,
  odds decimal NOT NULL,
  status text NOT NULL DEFAULT 'pending',
  created_at timestamptz DEFAULT now()
);

-- Safe creation of transactions table
CREATE TABLE IF NOT EXISTS transactions (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid REFERENCES profiles,
  amount decimal NOT NULL,
  type text NOT NULL,
  created_at timestamptz DEFAULT now()
);

-- Safely enable RLS
DO $$
BEGIN
  EXECUTE 'ALTER TABLE profiles ENABLE ROW LEVEL SECURITY';
  EXECUTE 'ALTER TABLE bets ENABLE ROW LEVEL SECURITY';
  EXECUTE 'ALTER TABLE transactions ENABLE ROW LEVEL SECURITY';
EXCEPTION
  WHEN others THEN NULL;
END $$;

-- Safely create policies (dropping if they exist)
DO $$
BEGIN
  -- Profiles policies
  DROP POLICY IF EXISTS "Users can view own profile" ON profiles;
  DROP POLICY IF EXISTS "Users can update own profile" ON profiles;
  
  -- Bets policies
  DROP POLICY IF EXISTS "Users can create own bets" ON bets;
  DROP POLICY IF EXISTS "Users can view own bets" ON bets;
  
  -- Transactions policies
  DROP POLICY IF EXISTS "Users can create own transactions" ON transactions;
  DROP POLICY IF EXISTS "Users can view own transactions" ON transactions;
END $$;

-- Create profiles policies
CREATE POLICY "Users can view own profile"
  ON profiles
  FOR SELECT
  TO authenticated
  USING (auth.uid() = id);

CREATE POLICY "Users can update own profile"
  ON profiles
  FOR UPDATE
  TO authenticated
  USING (auth.uid() = id);

-- Create bets policies
CREATE POLICY "Users can create own bets"
  ON bets
  FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can view own bets"
  ON bets
  FOR SELECT
  TO authenticated
  USING (auth.uid() = user_id);

-- Create transactions policies
CREATE POLICY "Users can create own transactions"
  ON transactions
  FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can view own transactions"
  ON transactions
  FOR SELECT
  TO authenticated
  USING (auth.uid() = user_id);