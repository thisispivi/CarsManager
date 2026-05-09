module.exports = {
  'cars_manager/lib/**.dart': [
    'dart format --set-exit-if-changed',
    'dart analyze',
  ],
  'cars_manager/test/**.dart': [
    'dart format --set-exit-if-changed',
  ],
};
