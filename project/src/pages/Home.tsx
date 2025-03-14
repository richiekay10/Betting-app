import React from 'react';
import { Trophy, TrendingUp, Shield, Users } from 'lucide-react';

export const Home = () => {
  return (
    <div className="min-h-screen bg-gray-50">
      {/* Hero Section */}
      <div className="bg-indigo-600 text-white py-20">
        <div className="container mx-auto px-4 text-center">
          <h1 className="text-5xl font-bold mb-6">Welcome to BetMaster</h1>
          <p className="text-xl mb-8">The most trusted betting platform for sports enthusiasts</p>
          <img
            src="https://images.unsplash.com/photo-1518133910546-b6c2fb7d79e3?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80"
            alt="Sports"
            className="rounded-lg shadow-xl mx-auto max-w-4xl"
          />
        </div>
      </div>

      {/* Features Section */}
      <div className="py-16">
        <div className="container mx-auto px-4">
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
            <FeatureCard
              icon={<Trophy className="w-12 h-12 text-indigo-600" />}
              title="Best Odds"
              description="Get competitive odds across all major sports"
            />
            <FeatureCard
              icon={<TrendingUp className="w-12 h-12 text-indigo-600" />}
              title="Live Betting"
              description="Place bets in real-time during matches"
            />
            <FeatureCard
              icon={<Shield className="w-12 h-12 text-indigo-600" />}
              title="Secure Platform"
              description="Your funds and data are always protected"
            />
            <FeatureCard
              icon={<Users className="w-12 h-12 text-indigo-600" />}
              title="Active Community"
              description="Join thousands of sports betting enthusiasts"
            />
          </div>
        </div>
      </div>
    </div>
  );
};

const FeatureCard = ({ icon, title, description }: { icon: React.ReactNode, title: string, description: string }) => (
  <div className="bg-white p-6 rounded-lg shadow-md text-center">
    <div className="flex justify-center mb-4">{icon}</div>
    <h3 className="text-xl font-semibold mb-2">{title}</h3>
    <p className="text-gray-600">{description}</p>
  </div>
);