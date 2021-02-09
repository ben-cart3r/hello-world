module.exports = {
    globals: {
        "ts-jest": {
            tsconfig: "tsconfig.json",
        },
    },
    moduleFileExtensions: ["ts", "js"],
    modulePathIgnorePatterns: ["<rootDir>/dist/"],
    transform: {
        "^.+\\.(ts)$": "ts-jest",
    },
    testEnvironment: "node",
    collectCoverage: true,
    collectCoverageFrom: ["**/*.ts", "!**/node_modules/**"],
};
