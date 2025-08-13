import { Link } from "wouter";

const NotFound = () => {
  return (
    <div className="min-h-screen flex flex-col items-center justify-center bg-[#0d1b2a] text-white px-4">
      <h1 className="text-6xl font-bold mb-4">404</h1>
      <p className="text-lg text-gray-300 mb-6">
        Oops! The page you’re looking for doesn’t exist.
      </p>
      <Link
        to="/"
        className="px-6 py-3 bg-blue-600 hover:bg-blue-500 rounded-lg shadow-md transition duration-300"
      >
        Go Home
      </Link>
    </div>
  );
};

export default NotFound;
