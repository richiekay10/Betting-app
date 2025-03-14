import React from 'react';
import { Link } from 'react-router-dom';
import { useAuthStore } from '../store/authStore';
import { LogOut, Trophy } from 'lucide-react';

export const Navbar = () => {
  const { user, signOut } = useAuthStore();

  return (
    <nav className="bg-indigo-600 text-white p-4">
      <div className="container mx-auto flex justify-between items-center">
        <Link to="/" className="flex items-center space-x-2 text-xl font-bold">
          <Trophy size={24} />
          <span>BetMaster</span>
        </Link>
        
        <div className="flex items-center space-x-6">
          {user ? (
            <>
              <Link to="/dashboard" className="hover:text-indigo-200">Dashboard</Link>
              <Link to="/bets" className="hover:text-indigo-200">My Bets</Link>
              <button
                onClick={() => signOut()}
                className="flex items-center space-x-1 hover:text-indigo-200"
              >
                <LogOut size={18} />
                <span>Sign Out</span>
              </button>
            </>
          ) : (
            <>
              <Link to="/login" className="hover:text-indigo-200">Login</Link>
              <Link to="/register" className="hover:text-indigo-200">Register</Link>
            </>
          )}
        </div>
      </div>
    </nav>
  );
};