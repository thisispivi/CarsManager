const quote = (file) => `"${file.replaceAll('"', '\\"')}"`;

module.exports = {
  'cars_manager/{lib,test}/**/*.dart': (files) => {
    // Process files in smaller batches to avoid timeouts
    const batchSize = 10;
    const batches = [];

    for (let i = 0; i < files.length; i += batchSize) {
      const batch = files.slice(i, i + batchSize);
      batches.push(`dart format ${batch.map(quote).join(' ')}`);
    }

    // Add flutter analyze once for all files
    batches.push('cd cars_manager && flutter analyze --fatal-infos');

    return batches;
  },
  'cars_manager/**/*.{yaml,yml,json,html,xml,kt,kts,md}': () => 'npm run verify',
};
