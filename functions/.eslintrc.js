module.exports = {
  root: true,
  plugins: [
    "import",
    "prettier",
    "promise",
  ],
  parser: "@babel/eslint-parser",
  parserOptions: {
    sourceType: "module",
  },
  env: {
    es6: true,
    node: true,
  },
  extends: [
    "eslint:recommended",
    "google",
    "prettier" // (error : "expected indentation of 2 spaces but found 4.") eslint prettier 충돌 문제로 추가 시켜줌
  ],
  rules: {
    quotes: ["error", "double"],
    "require-jsdoc": 0
  },

};
