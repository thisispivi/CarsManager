module.exports = {
  extends: ['@commitlint/config-conventional'],
  rules: {
    'type-enum': [
      2,
      'always',
      [
        'feat',
        'fix',
        'perf',
        'refactor',
        'style',
        'test',
        'docs',
        'ci',
        'build',
        'chore',
        'revert',
      ],
    ],
    'subject-max-length': [2, 'always', 100],
    'body-max-line-length': [2, 'always', 120],
  },
};
