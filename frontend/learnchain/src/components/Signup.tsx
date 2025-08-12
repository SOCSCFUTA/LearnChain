import React from "react";
import { FaWallet } from "react-icons/fa";
import { MdEmail } from "react-icons/md";
import { FcGoogle } from "react-icons/fc";

const handleGoogleSignUp = () => {
    alert("Google sign-up logic here");
};

const Signup = () => {
    const [showEmailForm, setShowEmailForm] = React.useState(false);
    return (
        <div className="min-h-screen bg-[#0d1b2a] flex items-center justify-center p-4">
            <div className="bg-[#1b263b] rounded-2xl shadow-lg p-8 max-w-md w-full text-center border border-blue-500/30">
                {/* Title */}
                <h1 className="text-3xl font-bold text-white mb-2">Create Account</h1>
                <p className="text-blue-200 text-sm mb-8">
                   A secure, blockchain-powered vault for your institution’s certificates
                </p>

                {/* Connect Wallet Button */}
                <button
                    className="w-full flex items-center justify-center gap-3 bg-gradient-to-r from-blue-600 to-blue-500 text-white font-semibold py-3 px-4 rounded-lg shadow-lg hover:from-blue-500 hover:to-blue-400 transition-all duration-300 transform hover:scale-105"
                >
                    <FaWallet size={20} />
                    Connect Wallet
                </button>

                {/* Divider */}
                <div className="flex items-center my-6">
                    <div className="flex-1 h-px bg-blue-500/30"></div>
                    <span className="px-3 text-blue-300 text-sm">OR</span>
                    <div className="flex-1 h-px bg-blue-500/30"></div>
                </div>

                {/* Email Signup */}
                <button
                    onClick={() => setShowEmailForm(!showEmailForm)}
                    className="w-full flex items-center justify-center gap-3 bg-[#0d1b2a] border border-blue-500/40 text-blue-200 font-medium py-3 px-4 rounded-lg hover:bg-[#112240] transition-all duration-300"
                >
                    <MdEmail size={20} />
                    Sign up with Email
                </button>

                {showEmailForm && (
                    <form
                        onSubmit={(e) => {
                            e.preventDefault();
                            alert("Email sign-up logic here");
                        }}
                        className="bg-[#0a192f] p-4 rounded-lg space-y-4"
                    >
                        <input
                            type="text"
                            placeholder="Full Name"
                            className="w-full p-3 rounded-lg bg-gray-800 text-white border border-gray-600 focus:outline-none focus:ring-2 focus:ring-blue-500"
                            required
                        />
                        <input
                            type="email"
                            placeholder="Enter your email"
                            className="w-full p-3 rounded-lg bg-gray-800 text-white border border-gray-600 focus:outline-none focus:ring-2 focus:ring-blue-500"
                            required
                        />
                        <input
                            type="password"
                            placeholder="Create a password"
                            className="w-full p-3 rounded-lg bg-gray-800 text-white border border-gray-600 focus:outline-none focus:ring-2 focus:ring-blue-500"
                            required
                        />
                        <button
                            type="submit"
                            className="w-full bg-blue-600 hover:bg-blue-700 py-3 rounded-lg font-semibold transition"
                        >
                            Sign Up
                        </button>
                    </form>
                )}

                {/* Google Signup */}
                <div className="flex justify-center mt-4">
                    <button
                        onClick={handleGoogleSignUp}
                        className="flex items-center gap-2 bg-white text-gray-700 px-4 py-2 rounded-lg shadow hover:shadow-md transition"
                    >
                        <FcGoogle size={20} />
                        <span>Sign up with Google</span>
                    </button>
                </div>

                {/* Footer */}
                <p className="text-xs text-blue-400 mt-6">
                    Already have an account?{" "}
                    <a href="/login" className="underline hover:text-blue-300">
                        Log in
                    </a>
                </p>
            </div>
        </div>
    );
};

export default Signup;
